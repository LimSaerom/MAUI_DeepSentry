using Firebase.Storage;    // Firebase Storage 사용을 위한 패키지
using MauiApp1.Models;
using Microsoft.Maui.Controls.PlatformConfiguration;
using System.Collections.ObjectModel;
using System.Diagnostics;
using CommunityToolkit.Maui; // MediaElement 사용을 위한 패키지
using Microcharts;
using Microcharts.Maui;
using SkiaSharp;
using CommunityToolkit.Maui.Views;

namespace MauiApp1;

public partial class MonitoringPage : ContentPage
{
    private DBManager db;          //DB 변수 선언

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
        BindingContext = this; // 바인딩 연결
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
                Debug.WriteLine($"[경고] 알 수 없는 카메라 위치: {detLocation}");
                break;
        }
    }
    catch (Exception ex)
    {
        Debug.WriteLine($"[FirebaseStorage] 동영상 URL 변환 실패: {ex.Message}");
        await DisplayAlert("오류", "영상을 불러오는 데 실패했습니다.", "확인");
    }
}

    /*
    // Firebase Storage URL에서 실제 다운로드 가능한 URL 반환
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
            Debug.WriteLine($"[FirebaseStorage] URL 변환 실패: {ex.Message}");
            await DisplayAlert("오류", "영상을 불러오는 데 실패했습니다.", "확인");
            return string.Empty;
        }
    }

    private async Task LoadVideoFromStorageAsync(string videoUrl)
    {
        try
        {
            if (!videoUrl.StartsWith("gs://"))
            {
                // gs:// 형식이 아니면 원본 URL 그대로 사용
                VideoPlayer1.Source = videoUrl;
                VideoPlayer2.Source = videoUrl;
                VideoPlayer3.Source = videoUrl;
                VideoPlayer4.Source = videoUrl;
                return;
            }

            var firebaseStorage = new FirebaseStorage("deepsentry-39f58.appspot.com");

            // gs:// 경로에서 상대 경로 추출
            var relativePath = videoUrl.Replace("gs://deepsentry-39f58.appspot.com/", "");

            // 다운로드 가능한 URL 얻기
            var downloadUrl = await firebaseStorage.Child(relativePath).GetDownloadUrlAsync();

            VideoPlayer1.Source = downloadUrl;
            VideoPlayer2.Source = downloadUrl;
            VideoPlayer3.Source = downloadUrl;
            VideoPlayer4.Source = downloadUrl;
        }
        catch (Exception ex)
        {
            Debug.WriteLine($"[FirebaseStorage] 동영상 URL 변환 실패: {ex.Message}");
            await DisplayAlert("오류", "영상을 불러오는 데 실패했습니다.", "확인");
        }
    }*/
    

    private async Task LoadLatestLog()
    {
        db = new DBManager();
        await db.DBloadAsync();

        var allLogs = await db.GetLogItemsAsync();

        var todaysAgo = DateTime.Now.AddDays(-1);
        //var todaysAgo = DateTime.Now.AddSeconds(-10);     //테스트완료
        System.Diagnostics.Debug.WriteLine($"Now: {DateTime.Now}, Filter 기준: {todaysAgo}");

        var recentLogs = allLogs
        .Select(log =>
        {
            // 예: "2025-05-30 14:23:10" 형태로 조합
            var dateTimeString = $"{log.DetDate} {log.DetTime}";

            // 날짜 파싱 시도
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
                    var videoUrl = logEntry.Log.VideoUrls?.FirstOrDefault(); // 최신 영상 1개만
                    if (!string.IsNullOrEmpty(videoUrl))
                    {
                        await LoadVideoFromStorageAsync(videoUrl, logEntry.Log.DetLocation);
                    }
                }
            }
        }

        else
        {
            DetLocation = "기록 없음";
            DetAnimal = "감지 내역 없음";
            LatestLog = null; //  최신 로그 없음 처리
        }
        */

        if (recentLogs.Any())
        {
            // 캠별로 최신 로그를 저장
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
                        await LoadVideoFromStorageAsync(videoUrl, cam); // 기존 함수
                    }

                    // 캠별로 라벨 텍스트를 세팅
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
            DetLocation = "기록 없음";
            DetAnimal = "감지 내역 없음";
            LatestLog = null;
        }



        OnPropertyChanged(nameof(DetLocation)); // 바인딩 값 갱신 알림
        OnPropertyChanged(nameof(DetAnimal)); // 바인딩 값 갱신 알림
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
        { "멧돼지", 0 },
        { "고라니", 0 },
        { "곰", 0 },
        { "사람", 0 }
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
                "곰" => "bear",
                "멧돼지" => "boar",
                "고라니" => "waterdear",
                "사람" => "human",
                _ => ac.Key
            };

            return new ChartEntry(count)
            {
                Label = labelEng,
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

        minichart.Chart = new BarChart
        {
            Entries = entries,
            LabelTextSize = 25,
            LabelOrientation = Orientation.Horizontal, // 가로 시도
            ValueLabelOrientation = Orientation.Horizontal // 가로 시도
        };
    }


    /*      일자별 조회보다 금일기준 탐지된 전체 객체를 보는게 좋겠단 피드백을 받음
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
            // 최신 로그가 없거나 동물 정보가 없으면 빈 차트 혹은 기본 처리
            minichart.Chart = null;
            return;
        }

        string targetAnimal = LatestLog.DetAnimal;

        // 오늘부터 7일 전 날짜 리스트 생성
        DateTime today = DateTime.Today;
        DateTime startDate = today.AddDays(-6); // 오늘 포함 7일간 (0~6)

        var dateList = Enumerable.Range(0, 7)
            .Select(offset => startDate.AddDays(offset))
            .ToList();

        // 날짜별 감지 횟수 집계 (targetAnimal 만 필터)
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

        // entries 생성
        var entries = dailyCounts.Select(dc =>
        {
            string label = dc.Date.ToString("MM/dd");
            return new ChartEntry(dc.Count)
            {
                Label = label,
                ValueLabel = dc.Count.ToString(),
                Color = SKColor.Parse("#3498db") // 임의 색상 (파란색)
            };
        }).ToArray();

        minichart.Chart = new BarChart
        {
            Entries = entries,
            LabelTextSize = 25,
            LabelOrientation = Orientation.Horizontal, // 가로 시도
            ValueLabelOrientation = Orientation.Horizontal // 가로 시도
        };
    }
    */



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