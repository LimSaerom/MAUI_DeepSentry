using Google.Cloud.Firestore;
using MauiApp1.Models;
using System.Diagnostics;


namespace MauiApp1
{
    public partial class MainPage : ContentPage
    {
        private DBManager db;

        public MainPage()
        {
            InitializeComponent();

            db = new DBManager();  // 여기서 초기화 꼭 해야 함

            Loaded += MainPage_Loaded; // 페이지 로드 시점에서 Firebase 초기화
            /* 내장 db 파일 경로 설정_로컬DB를 사용하지 않고 Firebase DB를 사용하기 때문에 주석처리
            string appDbPath = Path.Combine(FileSystem.AppDataDirectory, "app.db");
            //string copiedDbPath = Path.Combine(FileSystem.Current.CacheDirectory, "copied_app.db");



            
            // copied_app.db가 존재하면 app.db로 덮어쓰기
            if (File.Exists(copiedDbPath))
            {
                File.Copy(copiedDbPath, appDbPath, true); // 강제로 덮어쓰기
            }


            //db = new DBManager(appDbPath);

            /* 최초 1회 실행 (app.db → 로컬환경으로 복사)
            string dbPath = Path.Combine(FileSystem.AppDataDirectory, "app.db");
            var db = new DBManager(dbPath);
            //_ = db.InitializeTestDataAsync();  // 초기 더미 데이터 넣기 (비동기 무시하지 마세요)
            */
        }

        private async void MainPage_Loaded(object sender, EventArgs e)
        {
            try
            {
                await db.DBloadAsync(); // Firebase 연결 시도
                Debug.WriteLine("✅ Firestore 초기화 성공");
                TestFirebase(true);
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"❌ Firestore 초기화 실패: {ex.Message}");
                TestFirebase(false, ex.Message);
                await DisplayAlert("에러", "Firebase 연결에 실패했습니다.\n앱을 재실행해주세요.", "확인");
            }
        }


        async void TestFirebase(bool success, string errorMessage = null)
        {
            if (success)
            {
                LogLabel.Text = "✅ 데이터베이스 연결 성공!";
                //await db.Add_Document_with_AutoID();   //→더미데이터추가 코드
            }
            else
            {
                LogLabel.Text = $"❌ 예외 발생: {errorMessage}";
            }
        }




        private async void NextClicked(object sender, EventArgs e)
        {
            string input = InputEntry.Text?.Trim(); // 공백 제거
            bool IdCheck = IdCheckbox.IsChecked;

            if (input == null)
            {
                await DisplayAlert("알림", "아이디를 입력하세요.", "확인");
                return;
            }

            
            else
            {
                bool exists = await MemberExistsAsync(input);

                if (!exists)
                {
                    await DisplayAlert("알림", "존재하지 않는 아이디입니다.", "확인");
                    return;
                }

                AppState.CurrentMemberId = input;


                await Navigation.PushAsync(new MonitoringPage());
            }

            
            if (IdCheck)
            {
                input = InputEntry.Text?.Trim();
            }

            else
            {
                InputEntry.Text = null;
            }
        }

        public async Task<bool> MemberExistsAsync(string loginId)
        {
            var collection = db.Collection("LogRecord");  // 실제 Firestore에서 멤버가 저장된 컬렉션명 맞게 수정 필요
            var query = collection.WhereEqualTo("LoginID", loginId).Limit(1);
            var snapshot = await query.GetSnapshotAsync();
            return snapshot.Count > 0;
        }

        /* 실패코드(db를 로컬로 내보내는건 adb 프롬프트로만 가능)
        public async void CopyDbToExternal(object sender, EventArgs e)
        {
            try
            {
                string sourcePath = Path.Combine(FileSystem.AppDataDirectory, "app.db");
                //string destPath = Path.Combine(FileSystem.Current.CacheDirectory, "copied_app.db");
                string destPath = Path.Combine(FileSystem.Current.CacheDirectory, "copy_app0525.db");

                File.Copy(sourcePath, destPath, true);

                await Application.Current.MainPage.DisplayAlert("성공", $"DB 복사 완료!\n\n{destPath}", "확인");
            }
            catch (Exception ex)
            {
                await Application.Current.MainPage.DisplayAlert("에러", $"DB 복사 실패: {ex.Message}", "확인");
            }
        }
        

        public async void Overwritedb(object sender, EventArgs e)       //OverwriteAppDbFromCopiedDb
        {
            try
            {
                string destPath = Path.Combine(FileSystem.AppDataDirectory, "app.db");
                string sourcePath = Path.Combine(FileSystem.Current.CacheDirectory, "copied_app.db");

                File.Copy(sourcePath, destPath, true);  // 덮어쓰기
                await Application.Current.MainPage.DisplayAlert("성공", $"copied_app.db → app.db 덮어쓰기 완료!", "확인");
            }
            catch (Exception ex)
            {
                await Application.Current.MainPage.DisplayAlert("에러", $"DB 덮어쓰기 실패: {ex.Message}", "확인");
            }
        }
        */

        private async void OnPrintPathClicked(object sender, EventArgs e)
        {
            string dbPath = Path.Combine(FileSystem.AppDataDirectory, "app.db3");
            await Application.Current.MainPage.DisplayAlert("DB 경로", dbPath, "확인");
        }

    }

}
