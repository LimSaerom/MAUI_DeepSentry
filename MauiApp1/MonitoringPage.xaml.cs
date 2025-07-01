using Firebase.Storage;    // Firebase Storage ����� ���� ��Ű��
using MauiApp1.Models;
using Microsoft.Maui.Controls.PlatformConfiguration;
using System.Collections.ObjectModel;
using System.Diagnostics;
using CommunityToolkit.Maui; // MediaElement ����� ���� ��Ű��
using Microcharts;
using Microcharts.Maui;
using SkiaSharp;
using CommunityToolkit.Maui.Views;

namespace MauiApp1;

public partial class MonitoringPage : ContentPage
{
    private DBManager db;          //DB ���� ����

    public LogItem LatestLog { get; set; }

    public ObservableCollection<LogItem> CameraItems { get; set; } = new();

    public string DetLocation { get; set; }
    public string DetAnimal { get; set; }
    public string DetAnimal1 { get; set; }
    public string DetAnimal2 { get; set; }
    public string DetAnimal3 { get; set; }
    public string DetAnimal4 { get; set; }



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

    private async Task LoadVideoFromStorageAsync(string videoUrl, string detLocation)
{
    try
    {
        string resolvedUrl = videoUrl;

        if (videoUrl.StartsWith("gs://"))
        {
            var firebaseStorage = new FirebaseStorage("deepsentry-39f58.appspot.com");
            var relativePath = videoUrl.Replace("gs://deepsentry-39f58.appspot.com/", "");
            resolvedUrl = await firebaseStorage.Child(relativePath).GetDownloadUrlAsync();
        }

        switch (detLocation.ToLower())
        {
            case "cam1":
                VideoPlayer1.Source = resolvedUrl;
                break;
            case "cam2":
                VideoPlayer2.Source = resolvedUrl;
                break;
            case "cam3":
                VideoPlayer3.Source = resolvedUrl;
                break;
            case "cam4":
                VideoPlayer4.Source = resolvedUrl;
                break;
            default:
                Debug.WriteLine($"[���] �� �� ���� ī�޶� ��ġ: {detLocation}");
                break;
        }
    }
    catch (Exception ex)
    {
        Debug.WriteLine($"[FirebaseStorage] ������ URL ��ȯ ����: {ex.Message}");
        await DisplayAlert("����", "������ �ҷ����� �� �����߽��ϴ�.", "Ȯ��");
    }
}

    /*
    // Firebase Storage URL���� ���� �ٿ�ε� ������ URL ��ȯ
    private async Task<string> GetFirebaseDownloadUrl(string videoUrl)
    {
        if (string.IsNullOrWhiteSpace(videoUrl))
            return string.Empty;

        if (!videoUrl.StartsWith("gs://"))
            return videoUrl;

        try
        {
            var relativePath = videoUrl.Replace("gs://deepsentry-39f58.appspot.com/", "");
            var storage = new FirebaseStorage("deepsentry-39f58.appspot.com");
            return await storage.Child(relativePath).GetDownloadUrlAsync();
        }
        catch (Exception ex)
        {
            Debug.WriteLine($"[FirebaseStorage] URL ��ȯ ����: {ex.Message}");
            await DisplayAlert("����", "������ �ҷ����� �� �����߽��ϴ�.", "Ȯ��");
            return string.Empty;
        }
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
    }*/
    

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


        /*
        if (recentLogs.Any())
        {
            var latest = recentLogs.First();
            DetAnimal = latest.Log.DetAnimal;
            LatestLog = latest.Log;

            if (recentLogs.Any())
            {
                foreach (var logEntry in recentLogs)
                {
                    var videoUrl = logEntry.Log.VideoUrls?.FirstOrDefault(); // �ֽ� ���� 1����
                    if (!string.IsNullOrEmpty(videoUrl))
                    {
                        await LoadVideoFromStorageAsync(videoUrl, logEntry.Log.DetLocation);
                    }
                }
            }
        }

        else
        {
            DetLocation = "��� ����";
            DetAnimal = "���� ���� ����";
            LatestLog = null; //  �ֽ� �α� ���� ó��
        }
        */

        if (recentLogs.Any())
        {
            // ķ���� �ֽ� �α׸� ����
            var camLatestLogs = new Dictionary<string, LogItem>();

            foreach (var logEntry in recentLogs)
            {
                var cam = logEntry.Log.DetLocation?.ToLower();
                if (!camLatestLogs.ContainsKey(cam))
                {
                    camLatestLogs[cam] = logEntry.Log;

                    var videoUrl = logEntry.Log.VideoUrls?.FirstOrDefault();
                    if (!string.IsNullOrEmpty(videoUrl))
                    {
                        await LoadVideoFromStorageAsync(videoUrl, cam); // ���� �Լ�
                    }

                    // ķ���� �� �ؽ�Ʈ�� ����
                    switch (cam)
                    {
                        case "cam1":
                            DetAnimal1 = logEntry.Log.DetAnimal ?? null;
                            break;
                        case "cam2":
                            DetAnimal2 = logEntry.Log.DetAnimal ?? null; ;
                            break;
                        case "cam3":
                            DetAnimal3 = logEntry.Log.DetAnimal ?? null;
                            break;
                        case "cam4":
                            DetAnimal4 = logEntry.Log.DetAnimal ?? null;
                            break;
                    }
                }
            }
        }
        else
        {
            DetLocation = "��� ����";
            DetAnimal = "���� ���� ����";
            LatestLog = null;
        }



        OnPropertyChanged(nameof(DetLocation)); // ���ε� �� ���� �˸�
        OnPropertyChanged(nameof(DetAnimal)); // ���ε� �� ���� �˸�
        OnPropertyChanged(nameof(DetAnimal1));
        OnPropertyChanged(nameof(DetAnimal2));
        OnPropertyChanged(nameof(DetAnimal3));
        OnPropertyChanged(nameof(DetAnimal4));

    }

    private async Task LoadChartData()
    {
        if (db == null)
        {
            db = new DBManager();
            await db.DBloadAsync();
        }

        var logItems = await db.GetLogItemsAsync() ?? new List<LogItem>();

        DateTime todayStart = DateTime.Today;
        DateTime todayEnd = todayStart.AddDays(1).AddTicks(-1);

        var filteredLogs = logItems
            .Where(log =>
            {
                var dateTimeStr = $"{log.DetDate} {log.DetTime}";
                if (DateTime.TryParse(dateTimeStr, out DateTime parsed))
                    return parsed >= todayStart && parsed <= todayEnd;
                return false;
            })
            .ToList();

        var animalCounts = new Dictionary<string, int>
    {
        { "�����", 0 },
        { "����", 0 },
        { "��", 0 },
        { "���", 0 }
    };

        foreach (var item in filteredLogs)
        {
            if (!string.IsNullOrEmpty(item.DetAnimal) && animalCounts.ContainsKey(item.DetAnimal))
                animalCounts[item.DetAnimal]++;
        }

        int total = animalCounts.Values.Sum();

        var entries = animalCounts.Select(ac =>
        {
            int count = ac.Value;
            float percentage = total > 0 ? (float)count / total * 100 : 0;
            string labelEng = ac.Key switch
            {
                "��" => "bear",
                "�����" => "boar",
                "����" => "waterdear",
                "���" => "human",
                _ => ac.Key
            };

            return new ChartEntry(count)
            {
                Label = labelEng,
                ValueLabel = $"{count} ({percentage:F1}%)",
                Color = ac.Key switch
                {
                    "�����" => SKColor.Parse("#ff9900"),
                    "����" => SKColor.Parse("#008000"),
                    "��" => SKColor.Parse("#e6e600"),
                    "���" => SKColor.Parse("#ff00aa"),
                    _ => SKColor.Parse("#CCCCCC")
                }
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


    /*      ���ں� ��ȸ���� ���ϱ��� Ž���� ��ü ��ü�� ���°� ���ڴ� �ǵ���� ����
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
    */



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