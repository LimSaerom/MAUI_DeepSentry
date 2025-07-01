using MauiApp1.Models;
using Microcharts;
using Microcharts.Maui;
using SkiaSharp;
using System.Diagnostics;




namespace MauiApp1;

public partial class GraphPage : ContentPage
{
    private DBManager db;          //DB ���� ����

    public GraphPage()
    {
        InitializeComponent();

        db = new DBManager();

        StartPic.Date = DateTime.Today;
        EndPic.Date = StartPic.Date;
        /*
        LogView.Chart = new DonutChart
        {
            Entries = vegiEntires,
            LabelTextSize = 25,
        };
        */
        InitializeAsync();
    }

    private async void InitializeAsync()
    {
        await db.DBloadAsync();  // Firestore DB �ʱ�ȭ �Ϸ� ���
        LoadChartData();
    }

    
    private async void LoadChartData()
    {

        var logItems = await db.GetLogItemsAsync() ?? new List<LogItem>();

        DateTime startDate = StartPic.Date;
        DateTime endDate = EndPic.Date.AddDays(1).AddTicks(-1); // �������� 23:59:59���� ����

        var filteredLogs = logItems
            .Where(log =>
            {
                var dateTimeStr = $"{log.DetDate} {log.DetTime}";
                if (DateTime.TryParse(dateTimeStr, out DateTime parsed))
                    return parsed >= startDate && parsed <= endDate;
                return false;
            })
            .ToList(); // ���� �α� ����Ʈ

        // ������ ���� ����
        var animalCounts = new Dictionary<string, int>
        {
            { "�����", 0 },
            { "����", 0 },
            { "��", 0 },
            { "���", 0 }
        };

        foreach (var item in filteredLogs)
        {
            if (animalCounts.ContainsKey(item.DetAnimal))
                animalCounts[item.DetAnimal]++;
        }

        int total = animalCounts.Values.Sum(); // ��ü �հ�


        // ChartEntry ����
        var entries = animalCounts.Select(ac =>
        {
            int count = ac.Value;
            float percentage = total > 0 ? (float)count / total * 100 : 0;
            string labelEng = ac.Key switch
            {
                "��" => "bear",
                "�����" => "boar",
                "����" => "waterdear",
                "���" => "etc",
                _ => ac.Key // �⺻�� ���� Ű ����
            };

            return new ChartEntry(count)
            {
                Label = labelEng, // �Ǵ� ac.Key
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

        LogView.Chart = new DonutChart
        {
            Entries = entries,
            LabelTextSize = 25
        };
    }

    
    private void OnDateRangeChanged(object sender, CheckedChangedEventArgs e)
    {
        if (!(sender is RadioButton rb) || !rb.IsChecked)
            return;

        DateTime startDate = DateTime.Today;
        DateTime endDate = DateTime.Today;


        if (rb.Value?.ToString() != "self")
        {
            switch (rb.Value)
            {
                case "Today":
                    startDate = endDate = DateTime.Today;
                    break;

                case "1Week":
                    startDate = DateTime.Today.AddDays(-6);
                    endDate = DateTime.Today;
                    break;

                case "1Month":
                    startDate = DateTime.Today.AddMonths(-1);
                    endDate = DateTime.Today;
                    break;
            }

            StartPic.Date = startDate;
            EndPic.Date = endDate;
            SelectedDateLabel.Text = $"��ȸ �Ⱓ: {startDate:yyyy-MM-dd} ~ {endDate:yyyy-MM-dd}";


            DatePickerGroup.IsVisible = false;
        }


        else
        {
            DatePickerGroup.IsVisible = true;
            SelectedDateLabel.Text = "��ȸ�Ⱓ : ";

        }

        LoadChartData();       //��¥ ���� �� ��Ʈ �ٽ� �ε�

    }

    private void DateSelected(object sender, EventArgs e)
    {
        if (StartPic.Date > EndPic.Date)
            EndPic.Date = StartPic.Date;

        SelfRadio.IsChecked = true; // "��������" ��� ���� ����

        //SelectedDateLabel.Text = $"��ȸ �Ⱓ: {StartPic.Date:yyyy-MM-dd} ~ {EndPic.Date:yyyy-MM-dd}";

        LoadChartData();

    }


    private void StartPic_DateSelected(object sender, DateChangedEventArgs e)
    {
        // ���� ��¥�� ���� ��¥ ���İ� ���� �ʵ��� ����
        if (StartPic.Date > EndPic.Date)
            EndPic.Date = StartPic.Date;

        SelfRadio.IsChecked = true; // �ݵ�� "self"�� ��� ��ȯ

        SelectedDateLabel.Text = $"��ȸ �Ⱓ: {StartPic.Date:yyyy-MM-dd} ~ {EndPic.Date:yyyy-MM-dd}";

        LoadChartData();
    }

    private void EndPic_DateSelected(object sender, DateChangedEventArgs e)
    {
        // ���� ��¥�� ���� ��¥ ������ ���� �ʵ��� ����
        if (EndPic.Date < StartPic.Date)
            StartPic.Date = EndPic.Date;

        SelfRadio.IsChecked = true;


        SelectedDateLabel.Text = $"��ȸ �Ⱓ: {StartPic.Date:yyyy-MM-dd} ~ {EndPic.Date:yyyy-MM-dd}";

        LoadChartData();
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