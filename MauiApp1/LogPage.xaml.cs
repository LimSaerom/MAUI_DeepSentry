using System.Collections.ObjectModel;
using MauiApp1.Models;            
using System.Threading.Tasks;




namespace MauiApp1;

public partial class LogPage : ContentPage
{
    private DBManager db;          //DB ���� ����

    private List<LogItem> AllLogs;      //Firebase���� �α� �����͸� �������� Ŭ���� �ν��Ͻ�.

    // �÷��Ǻ信 ���ε��Ǵ� ���� ������ ������
    public ObservableCollection<LogItem> LogItems { get; set; } = new ObservableCollection<LogItem>();         //��ü �α׸� �����ϴ� �÷���. ����¡ ó���� �� ���� ������.

    private int currentPage = 0;
    private const int PageSize = 15;





    public LogPage()
    {
        InitializeComponent();

        db = new DBManager();


        // ���ε� ���� (ViewModel�� ����ϸ� BindingContext�� ����)
        LogListView.ItemsSource = LogItems;


        // ��ư �̺�Ʈ ����
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
            await DisplayAlert("����", $"������ �ε� �� ������ �߻��߽��ϴ�.\n{ex.Message}", "Ȯ��");
        }
    }

    private async Task InitializeAsync()
    {
        await db.DBloadAsync(); // Firebase ���� �ʱ�ȭ

        AllLogs = await db.GetLogItemsAsync(); // ������ ��������

        LoadPage(currentPage); // �ʱ� ������ �ε�
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