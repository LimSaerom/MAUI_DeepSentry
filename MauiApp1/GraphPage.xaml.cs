using MauiApp1.Models;
using Microcharts;
using Microcharts.Maui;
using SkiaSharp;
using System.Diagnostics;




namespace MauiApp1;

public partial class GraphPage : ContentPage
{
    private DBManager db;          //DB 변수 선언

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
        await db.DBloadAsync();  // Firestore DB 초기화 완료 대기
        LoadChartData();
    }

    
    private async void LoadChartData()
    {

        var logItems = await db.GetLogItemsAsync() ?? new List<LogItem>();

        DateTime startDate = StartPic.Date;
        DateTime endDate = EndPic.Date.AddDays(1).AddTicks(-1); // 종료일의 23:59:59까지 포함

        var filteredLogs = logItems
            .Where(log =>
            {
                var dateTimeStr = $"{log.DetDate} {log.DetTime}";
                if (DateTime.TryParse(dateTimeStr, out DateTime parsed))
                    return parsed >= startDate && parsed <= endDate;
                return false;
            })
            .ToList(); // 실제 로그 리스트

        // 동물별 개수 집계
        var animalCounts = new Dictionary<string, int>
        {
            { "멧돼지", 0 },
            { "고라니", 0 },
            { "곰", 0 },
            { "사람", 0 }
        };

        foreach (var item in filteredLogs)
        {
            if (animalCounts.ContainsKey(item.DetAnimal))
                animalCounts[item.DetAnimal]++;
        }

        int total = animalCounts.Values.Sum(); // 전체 합계


        // ChartEntry 생성
        var entries = animalCounts.Select(ac =>
        {
            int count = ac.Value;
            float percentage = total > 0 ? (float)count / total * 100 : 0;
            string labelEng = ac.Key switch
            {
                "곰" => "bear",
                "멧돼지" => "boar",
                "고라니" => "waterdear",
                "사람" => "etc",
                _ => ac.Key // 기본은 원래 키 유지
            };

            return new ChartEntry(count)
            {
                Label = labelEng, // 또는 ac.Key
                ValueLabel = $"{count} ({percentage:F1}%)",
                Color = ac.Key switch
                {
                    "멧돼지" => SKColor.Parse("#ff9900"),
                    "고라니" => SKColor.Parse("#008000"),
                    "곰" => SKColor.Parse("#e6e600"),
                    "사람" => SKColor.Parse("#ff00aa"),
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
            SelectedDateLabel.Text = $"조회 기간: {startDate:yyyy-MM-dd} ~ {endDate:yyyy-MM-dd}";


            DatePickerGroup.IsVisible = false;
        }


        else
        {
            DatePickerGroup.IsVisible = true;
            SelectedDateLabel.Text = "조회기간 : ";

        }

        LoadChartData();       //날짜 변경 후 차트 다시 로딩

    }

    private void DateSelected(object sender, EventArgs e)
    {
        if (StartPic.Date > EndPic.Date)
            EndPic.Date = StartPic.Date;

        SelfRadio.IsChecked = true; // "직접선택" 모드 강제 지정

        //SelectedDateLabel.Text = $"조회 기간: {StartPic.Date:yyyy-MM-dd} ~ {EndPic.Date:yyyy-MM-dd}";

        LoadChartData();

    }


    private void StartPic_DateSelected(object sender, DateChangedEventArgs e)
    {
        // 시작 날짜가 종료 날짜 이후가 되지 않도록 조정
        if (StartPic.Date > EndPic.Date)
            EndPic.Date = StartPic.Date;

        SelfRadio.IsChecked = true; // 반드시 "self"로 모드 전환

        SelectedDateLabel.Text = $"조회 기간: {StartPic.Date:yyyy-MM-dd} ~ {EndPic.Date:yyyy-MM-dd}";

        LoadChartData();
    }

    private void EndPic_DateSelected(object sender, DateChangedEventArgs e)
    {
        // 종료 날짜가 시작 날짜 이전이 되지 않도록 조정
        if (EndPic.Date < StartPic.Date)
            StartPic.Date = EndPic.Date;

        SelfRadio.IsChecked = true;


        SelectedDateLabel.Text = $"조회 기간: {StartPic.Date:yyyy-MM-dd} ~ {EndPic.Date:yyyy-MM-dd}";

        LoadChartData();
    }
    

    /// <summary>
    /// 1. 메뉴 선택시 자기자신을 선택하면 알림팝업 생성
    /// 2. 타메뉴 선택시 이동
    /// </summary>

    private async Task Navi(Page targetPage)
    {
        if (this.GetType() == targetPage.GetType())
        {
            await DisplayAlert("안내", "현재 페이지입니다.", "확인");
            return;
        }

        await Navigation.PushAsync(targetPage);
    }

    private void ToggleMenuBtn_Clicked(object sender, EventArgs e)
    {
        MenuPanel.IsVisible = !MenuPanel.IsVisible; // 토글로 메뉴 열고 닫기
    }

    private async void GoToPage_Clicked(object sender, EventArgs e)   //MainPage 연결
    {
        await Navi(new MonitoringPage());
    }

    private async void GoToPage1_Clicked(object sender, EventArgs e)   //LogPage 연결
    {
        await Navi(new LogPage());
    }

    private async void GoToPage2_Clicked(object sender, EventArgs e)   //GraphPage 연결
    {
        await Navi(new GraphPage());
    }

    





}