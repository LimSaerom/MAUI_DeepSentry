using Firebase.Storage;    // Firebase Storage ����� ���� ��Ű��
using MauiApp1.Models;
using Microsoft.Maui.Controls.PlatformConfiguration;
using System.Collections.ObjectModel;
using System.Diagnostics;
using CommunityToolkit.Maui; // MediaElement ����� ���� ��Ű��
using Microcharts;
using Microcharts.Maui;
using SkiaSharp;

namespace MauiApp1;

public partial class MonitoringPage : ContentPage
{
    private DBManager db;          //DB ���� ����

    public LogItem LatestLog { get; set; }

    public string DetLocation { get; set; }
    public string DetAnimal { get; set; }



    public MonitoringPage()
    {
        InitializeComponent();
        BindingContext = this; // ���ε� ����
        InitializeAsync();

    }

    private async void InitializeAsync()
    {
        await LoadLatestLog();
        await LoadChartData();
    }

    private async Task LoadVideoFromStorageAsync(string videoUrl)
    {
        try
        {
            if (!videoUrl.StartsWith("gs://"))
            {
                // gs:// ������ �ƴϸ� ���� URL �״�� ���
                VideoPlayer1.Source = videoUrl;
                VideoPlayer2.Source = videoUrl;
                VideoPlayer3.Source = videoUrl;
                VideoPlayer4.Source = videoUrl;
                return;
            }

            var firebaseStorage = new FirebaseStorage("deepsentry-39f58.appspot.com");

            // gs:// ��ο��� ��� ��� ����
            var relativePath = videoUrl.Replace("gs://deepsentry-39f58.appspot.com/", "");

            // �ٿ�ε� ������ URL ���
            var downloadUrl = await firebaseStorage.Child(relativePath).GetDownloadUrlAsync();

            VideoPlayer1.Source = downloadUrl;
            VideoPlayer2.Source = downloadUrl;
            VideoPlayer3.Source = downloadUrl;
            VideoPlayer4.Source = downloadUrl;
        }
        catch (Exception ex)
        {
            Debug.WriteLine($"[FirebaseStorage] ������ URL ��ȯ ����: {ex.Message}");
            await DisplayAlert("����", "������ �ҷ����� �� �����߽��ϴ�.", "Ȯ��");
        }
    }


    private async Task LoadLatestLog()
    {
        db = new DBManager();
        await db.DBloadAsync();

        var allLogs = await db.GetLogItemsAsync();

        var todaysAgo = DateTime.Now.AddDays(-1);
        //var todaysAgo = DateTime.Now.AddSeconds(-10);     //�׽�Ʈ�Ϸ�
        System.Diagnostics.Debug.WriteLine($"Now: {DateTime.Now}, Filter ����: {todaysAgo}");

        var recentLogs = allLogs
        .Select(log =>
        {
            // ��: "2025-05-30 14:23:10" ���·� ����
            var dateTimeString = $"{log.DetDate} {log.DetTime}";

            // ��¥ �Ľ� �õ�
            if (DateTime.TryParse(dateTimeString, out DateTime parsedDateTime))
            {
                System.Diagnostics.Debug.WriteLine($" Parsed: {parsedDateTime}");
                return new { Log = log, ParsedDate = parsedDateTime };

            }
            else
            {
                return null;
            }
        })
        .Where(x => x != null && x.ParsedDate >= todaysAgo)
        .OrderByDescending(x => x.ParsedDate)
        .ToList();

        if (recentLogs.Any())
        {
            var latest = recentLogs.First();
            DetLocation = latest.Log.DetLocation;
            DetAnimal = latest.Log.DetAnimal;
            LatestLog = latest.Log;

            // �ֽ� �α��� VideoUrl�� ���� �ε�
            if (!string.IsNullOrEmpty(LatestLog.VideoUrl))
            {
                await LoadVideoFromStorageAsync(LatestLog.VideoUrl);
            }
        }

        else
        {
            DetLocation = "��� ����";
            DetAnimal = "���� ���� ����";
            LatestLog = null; //  �ֽ� �α� ���� ó��
        }




        OnPropertyChanged(nameof(DetLocation)); // ���ε� �� ���� �˸�
        OnPropertyChanged(nameof(DetAnimal));

    }

    private async Task LoadChartData()
    {
        if (db == null)
        {
            db = new DBManager();
            await db.DBloadAsync();
        }

        var logItems = await db.GetLogItemsAsync() ?? new List<LogItem>();

        if (LatestLog == null || string.IsNullOrEmpty(LatestLog.DetAnimal))
        {
            // �ֽ� �αװ� ���ų� ���� ������ ������ �� ��Ʈ Ȥ�� �⺻ ó��
            minichart.Chart = null;
            return;
        }

        string targetAnimal = LatestLog.DetAnimal;

        // ���ú��� 7�� �� ��¥ ����Ʈ ����
        DateTime today = DateTime.Today;
        DateTime startDate = today.AddDays(-6); // ���� ���� 7�ϰ� (0~6)

        var dateList = Enumerable.Range(0, 7)
            .Select(offset => startDate.AddDays(offset))
            .ToList();

        // ��¥�� ���� Ƚ�� ���� (targetAnimal �� ����)
        var dailyCounts = dateList.Select(date =>
        {
            int count = logItems.Count(log =>
            {
                var dateTimeStr = $"{log.DetDate} {log.DetTime}";
                if (DateTime.TryParse(dateTimeStr, out DateTime parsed))
                {
                    return parsed.Date == date.Date && log.DetAnimal == targetAnimal;
                }
                return false;
            });
            return new { Date = date, Count = count };
        }).ToList();

        // entries ����
        var entries = dailyCounts.Select(dc =>
        {
            string label = dc.Date.ToString("MM/dd");
            return new ChartEntry(dc.Count)
            {
                Label = label,
                ValueLabel = dc.Count.ToString(),
                Color = SKColor.Parse("#3498db") // ���� ���� (�Ķ���)
            };
        }).ToArray();

        minichart.Chart = new BarChart
        {
            Entries = entries,
            LabelTextSize = 25,
            LabelOrientation = Orientation.Horizontal, // ���� �õ�
            ValueLabelOrientation = Orientation.Horizontal // ���� �õ�
        };
    }



    /// <summary>
    /// 1. �޴� ���ý� �ڱ��ڽ��� �����ϸ� �˸��˾� ����
    /// 2. Ÿ�޴� ���ý� �̵�
    /// </summary>

    private async Task Navi(Page targetPage)
    {
        if (this.GetType() == targetPage.GetType())
        {
            await DisplayAlert("�ȳ�", "���� �������Դϴ�.", "Ȯ��");
            return;
        }

        await Navigation.PushAsync(targetPage);
    }

    private void ToggleMenuBtn_Clicked(object sender, EventArgs e)
    {
        MenuPanel.IsVisible = !MenuPanel.IsVisible; // ��۷� �޴� ���� �ݱ�
    }

    private async void GoToPage_Clicked(object sender, EventArgs e)   //MainPage ����
    {
        await Navi(new MonitoringPage());
    }

    private async void GoToPage1_Clicked(object sender, EventArgs e)   //LogPage ����
    {
        await Navi(new LogPage());
    }

    private async void GoToPage2_Clicked(object sender, EventArgs e)   //GraphPage ����
    {
        await Navi(new GraphPage());
    }

}