using System.Collections.ObjectModel;
using MauiApp1.Models;            
using System.Threading.Tasks;




namespace MauiApp1;

public partial class LogPage : ContentPage
{
    private DBManager db;          //DB 변수 선언

    private List<LogItem> AllLogs;      //Firebase에서 로그 데이터를 가져오는 클래스 인스턴스.

    // 컬렉션뷰에 바인딩되는 현재 페이지 데이터
    public ObservableCollection<LogItem> LogItems { get; set; } = new ObservableCollection<LogItem>();         //전체 로그를 저장하는 컬렉션. 페이징 처리할 때 기준 데이터.

    private int currentPage = 0;
    private const int PageSize = 15;





    public LogPage()
    {
        InitializeComponent();

        db = new DBManager();


        // 바인딩 설정 (ViewModel을 사용하면 BindingContext에 설정)
        LogListView.ItemsSource = LogItems;


        // 버튼 이벤트 연결
        BtnL.Clicked += BtnL_Clicked;
        BtnR.Clicked += BtnR_Clicked;

        InitializeSafe();
    }

    private async void InitializeSafe()
    {
        try
        {
            await InitializeAsync();
        }
        catch (Exception ex)
        {
            await DisplayAlert("오류", $"데이터 로딩 중 문제가 발생했습니다.\n{ex.Message}", "확인");
        }
    }

    private async Task InitializeAsync()
    {
        await db.DBloadAsync(); // Firebase 연결 초기화

        AllLogs = await db.GetLogItemsAsync(); // 데이터 가져오기

        LoadPage(currentPage); // 초기 페이지 로딩
    }


    private void LoadPage(int page)
    {
        LogItems.Clear();

        int start = page * PageSize;
        int end = Math.Min(start + PageSize, AllLogs.Count);

        for (int i = start; i < end; i++)
        {
            LogItems.Add(AllLogs[i]);
        }
    }

    private void BtnL_Clicked(object sender, EventArgs e)
    {
        if (currentPage > 0)
        {
            currentPage--;
            LoadPage(currentPage);
        }
    }

    private void BtnR_Clicked(object sender, EventArgs e)
    {
        if ((currentPage + 1) * PageSize < AllLogs.Count)
        {
            currentPage++;
            LoadPage(currentPage);
        }
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