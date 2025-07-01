namespace MauiApp1
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();

            //MainPage = new AppShell();

            //네비게이션 기능을 활용하여 페이지 전환을 하기 위함
            MainPage = new NavigationPage(new MainPage());

        }
    }
}
