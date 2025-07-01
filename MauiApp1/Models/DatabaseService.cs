using FirebaseAdmin;                  //
using Google.Apis.Auth.OAuth2;
using Google.Cloud.Firestore;         // Firestore 사용을 위한 패키지
using MauiApp1;
using System;
using System.Collections.Generic;
using System.Diagnostics;    //리스트 사용에 필요
using System.IO;                     //비동기 I/O 및 비동기 작업 처리에 필요
using System.Linq.Expressions;
using System.Threading.Tasks;        //비동기 I/O 및 비동기 작업 처리에 필요



namespace MauiApp1.Models
{
    public class CredentialFileHelper             //Firebase 비밀키 JSON 파일을 Android 내부 저장소로 복사
    {
        public static async Task<string> CopyFirebaseKeyToInternalStorage()
        {
#if ANDROID
        string fileName = "deepsentry-39f58-firebase-adminsdk-fbsvc-645bb22a0a.json"; // Raw 폴더의 파일명과 동일해야 함
        string destPath = Path.Combine(FileSystem.AppDataDirectory, fileName);

        if (!File.Exists(destPath))
        {
            var context = Android.App.Application.Context ?? throw new InvalidOperationException("Android context is null.");

            using (var assetStream = context.Assets.Open(fileName))
            using (var fileStream = File.Create(destPath))
            {
            await assetStream.CopyToAsync(fileStream);
            await fileStream.FlushAsync();  // 파일 버퍼 완전 비우기
            }
            //await assetStream.CopyToAsync(fileStream);
        }

        return destPath;
#else
            throw new PlatformNotSupportedException("현재 Android에서만 지원됩니다.");
#endif
        }
    }

    public class DBManager
    {
        //public FirestoreDb db;        //Firestore DB 연결 변수 선언_타클래스 참조를 위해 전역변수 선언
        public FirestoreDb db { get; private set; }  // 외부에서 db 설정 못하도록 보호 set(쓰기) 설정
        public MainPage MainPage { get; set; } // MainPage 인스턴스 참조

        public async Task DBloadAsync()       
        {
            string path = await CredentialFileHelper.CopyFirebaseKeyToInternalStorage();
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", path);

            await Task.Delay(200); // 파일 시스템 안정화 대기

            db = FirestoreDb.Create("deepsentry-39f58"); // 프로젝트 ID
            if (db == null)
                throw new InvalidOperationException("FirestoreDb 생성에 실패했습니다.");
        }

        public CollectionReference Collection(string collectionName)
        {
            return db.Collection(collectionName);
        }

        public async Task Add_Document_with_AutoID()
        {
            string detDate = DateTime.Now.ToString("yyyy-MM-dd");
            CollectionReference coll = db.Collection("LogRecord");
            List<Task> tasks = new List<Task>();

            int recordCount = 5;

            Random rand = new Random();
            int randomHour = rand.Next(0, 24);
            int randomMinute = rand.Next(0, 60);
            int randomSecond = rand.Next(0, 60);
            DateTime baseTime = new DateTime(2025, 6, 22, randomHour, randomMinute, randomSecond);

            for (int i = 0; i < recordCount; i++)
            {
                string detTime = baseTime.AddSeconds(i).ToString("HH:mm:ss");

                string detAnimal = rand.Next(1, 5).ToString();
                detAnimal = detAnimal switch
                {
                    "1" => "bear",
                    "2" => "waterdear",
                    "3" => "boar",
                    _ => "etc"
                };

                Dictionary<string, object> data = new Dictionary<string, object>()
        {
            {"LoginID", "admin" },
            {"DetDate", detDate },
            {"DetTime", detTime },
            {"DetAnimal", detAnimal },
            {"DetLocation", "Cam1" }
        };

                tasks.Add(coll.AddAsync(data));
            }

            await Task.WhenAll(tasks);
        }


        public async Task<List<LogItem>> GetLogItemsAsync()
        {
            var logItems = new List<LogItem>();
            string userId = AppState.CurrentMemberId;

            //CollectionReference collection = db.Collection("LogRecord");

            var query = db.Collection("LogRecord")
                        .WhereEqualTo("LoginID", userId) // 로그인 ID를 기준으로 로그가져오기
                        .OrderByDescending("DetDate")
                        .OrderByDescending("DetTime");


            QuerySnapshot snapshot = await query.GetSnapshotAsync();

            foreach (DocumentSnapshot doc in snapshot.Documents)
            {
                if (doc.Exists)
                {
                    var dict = doc.ToDictionary();
                    string detAnimal = dict.ContainsKey("DetAnimal") ? dict["DetAnimal"].ToString() : "";
                    string detAnimalKor = detAnimal switch
                    {
                        "bear" => "곰",
                        "boar" => "멧돼지",
                        "waterdear" => "고라니",
                        "etc" => "사람",
                        "곰" => "곰",
                        "멧돼지" => "멧돼지",
                        "고라니" => "고라니",
                        "사람" => "사람",
                        _ => "etc" // 기본값은 원래 영어 그대로
                    };

                    logItems.Add(new LogItem
                    {
                        LoginID = dict.ContainsKey("LoginID") ? dict["LoginID"].ToString() : "",
                        DetDate = dict.ContainsKey("DetDate") ? dict["DetDate"].ToString() : "",
                        DetTime = dict.ContainsKey("DetTime") ? dict["DetTime"].ToString() : "",
                        DetAnimal = detAnimalKor,
                        DetLocation = dict.ContainsKey("DetLocation") ? dict["DetLocation"].ToString() : "",
                        VideoUrl = dict.ContainsKey("VideoUrl") ? dict["VideoUrl"].ToString() : ""
                    });
                }
            }
            return logItems;
        }


        /* SQLite DB 사용 코드 → 실시간성을 위해 Firebase로 변경
         * 
         * SQLite DB 사용을 위한 코드입니다.
         * Member 테이블과 LogRecord 테이블을 정의하고,
         * DBManager 클래스를 통해 CRUD 작업을 수행합니다.
         * 
         * 주의: 이 코드는 SQLite 패키지가 설치되어 있어야 합니다.
         * 
        // 회원테이블
        public class Member
        {
            [PrimaryKey]
            public string ID { get; set; }
        }

        // 로그테이블
        public class LogRecord
        {
            [PrimaryKey, AutoIncrement]
            public int LogNo { get; set; }  // 고유 순번 (기본키)

            public string ID { get; set; }          // Member 테이블의 외래키
            public string DetDate { get; set; }     // yyyy-MM-dd
            public string DetTime { get; set; }     // HH:mm:ss
            public string DetAnimal { get; set; }   // 탐지된 객체명
            public string DetLocation { get; set; } // 탐지 위치
        }

        public class DBManager
        {
            readonly SQLiteAsyncConnection _DB;

            public DBManager(string dbPath)
            {
                try
                {
                    // SQLite DB 경로 연결
                    _DB = new SQLiteAsyncConnection(dbPath);

                    // 테이블 생성 (없으면 생성)
                    _DB.CreateTableAsync<Member>().Wait();
                    _DB.CreateTableAsync<LogRecord>().Wait();
                }
                catch (Exception ex)
                {
                    // 예외 발생 시 로그 출력 (디버깅용)
                    Debug.WriteLine(ex);
                }
            }


            // 로그 기록 조회(Member테이블에서 ID를 비교해서 연결해줌)
            public Task<List<LogRecord>> GetLogsByMemberTable(string MemberId)
            {
                return _DB.Table<LogRecord>()
                          .Where(log => log.ID == MemberId)
                          .ToListAsync();
            }

            // 로그 FIFO 삭제 (예: 최대 10000개 유지)
            public async Task DeleteOldLogsAsync(int maxCount = 10000)
            {
                var totalCount = await _DB.Table<LogRecord>().CountAsync();
                if (totalCount > maxCount)
                {
                    // 오래된 로그부터 삭제하기 위해 LogDate와 LogTime 기준 정렬
                    var logsToDelete = await _DB.Table<LogRecord>()
                        .OrderBy(l => l.DetDate)
                        .ThenBy(l => l.DetTime)
                        .Take(totalCount - maxCount)
                        .ToListAsync();

                    foreach (var log in logsToDelete)
                    {
                        await _DB.DeleteAsync(log);
                    }
                }
            }

            public async Task<bool> MemberExistsAsync(string id)
            {
                var member = await _DB.Table<Member>()
                                      .Where(m => m.ID == id)
                                      .FirstOrDefaultAsync();

                return member != null;
            }

            /*       db 직접 입력
            // ** 새로 추가한 메서드: 테스트용 더미 데이터 초기화 **
            public async Task InitializeTestDataAsync()
            {
                // 이미 데이터가 있으면 초기화 안함 (중복 방지)
                var memberCount = await _DB.Table<Member>().CountAsync();
                if (memberCount > 0) return;

                // 멤버 1명 추가 (ID는 AutoIncrement라 자동 생성)
                var member = new Member();
                await AddMemberAsync(member);

                // member.ID가 Insert 후에 자동 할당됨
                int memberId = member.ID;

                // 로그 5개 추가
                for (int i = 1; i <= 5; i++)
                {
                    var log = new LogRecord()
                    {
                        MemberID = memberId,
                        LogDate = DateTime.Now.ToString("yyyy-MM-dd"),
                        LogTime = DateTime.Now.ToString("HH:mm:ss"),
                        LogClassName = $"TestObject{i}",
                        LogLocation = $"TestLocation{i}"
                    };
                    await AddLogRecordAsync(log);
                }
            }
        }
        */

    }
}
