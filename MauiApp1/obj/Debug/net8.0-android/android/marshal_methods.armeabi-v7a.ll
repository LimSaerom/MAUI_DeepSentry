; ModuleID = 'marshal_methods.armeabi-v7a.ll'
source_filename = "marshal_methods.armeabi-v7a.ll"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv7-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [360 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [714 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 68
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 67
	i32 15721112, ; 2: System.Runtime.Intrinsics.dll => 0xefe298 => 108
	i32 32687329, ; 3: Xamarin.AndroidX.Lifecycle.Runtime => 0x1f2c4e1 => 274
	i32 34715100, ; 4: Xamarin.Google.Guava.ListenableFuture.dll => 0x211b5dc => 311
	i32 34839235, ; 5: System.IO.FileSystem.DriveInfo => 0x2139ac3 => 48
	i32 39109920, ; 6: Newtonsoft.Json.dll => 0x254c520 => 210
	i32 39485524, ; 7: System.Net.WebSockets.dll => 0x25a8054 => 80
	i32 42639949, ; 8: System.Threading.Thread => 0x28aa24d => 145
	i32 66541672, ; 9: System.Diagnostics.StackTrace => 0x3f75868 => 30
	i32 67008169, ; 10: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 352
	i32 68219467, ; 11: System.Security.Cryptography.Primitives => 0x410f24b => 124
	i32 72070932, ; 12: Microsoft.Maui.Graphics.dll => 0x44bb714 => 209
	i32 82292897, ; 13: System.Runtime.CompilerServices.VisualC.dll => 0x4e7b0a1 => 102
	i32 101534019, ; 14: Xamarin.AndroidX.SlidingPaneLayout => 0x60d4943 => 293
	i32 117431740, ; 15: System.Runtime.InteropServices => 0x6ffddbc => 107
	i32 120558881, ; 16: Xamarin.AndroidX.SlidingPaneLayout.dll => 0x72f9521 => 293
	i32 122350210, ; 17: System.Threading.Channels.dll => 0x74aea82 => 139
	i32 134690465, ; 18: Xamarin.Kotlin.StdLib.Jdk7.dll => 0x80736a1 => 315
	i32 142721839, ; 19: System.Net.WebHeaderCollection => 0x881c32f => 77
	i32 149972175, ; 20: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 124
	i32 159306688, ; 21: System.ComponentModel.Annotations => 0x97ed3c0 => 13
	i32 165246403, ; 22: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 248
	i32 176265551, ; 23: System.ServiceProcess => 0xa81994f => 132
	i32 182336117, ; 24: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 295
	i32 184328833, ; 25: System.ValueTuple.dll => 0xafca281 => 151
	i32 195452805, ; 26: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 349
	i32 199333315, ; 27: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 350
	i32 205061960, ; 28: System.ComponentModel => 0xc38ff48 => 18
	i32 209399409, ; 29: Xamarin.AndroidX.Browser.dll => 0xc7b2e71 => 246
	i32 220171995, ; 30: System.Diagnostics.Debug => 0xd1f8edb => 26
	i32 230216969, ; 31: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 0xdb8d509 => 268
	i32 230752869, ; 32: Microsoft.CSharp.dll => 0xdc10265 => 1
	i32 231409092, ; 33: System.Linq.Parallel => 0xdcb05c4 => 59
	i32 231814094, ; 34: System.Globalization => 0xdd133ce => 42
	i32 246610117, ; 35: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 91
	i32 261689757, ; 36: Xamarin.AndroidX.ConstraintLayout.dll => 0xf99119d => 251
	i32 266337479, ; 37: Xamarin.Google.Guava.FailureAccess.dll => 0xfdffcc7 => 310
	i32 276479776, ; 38: System.Threading.Timer.dll => 0x107abf20 => 147
	i32 278686392, ; 39: Xamarin.AndroidX.Lifecycle.LiveData.dll => 0x109c6ab8 => 270
	i32 280482487, ; 40: Xamarin.AndroidX.Interpolator => 0x10b7d2b7 => 267
	i32 280992041, ; 41: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 321
	i32 291076382, ; 42: System.IO.Pipes.AccessControl.dll => 0x1159791e => 54
	i32 293579439, ; 43: ExoPlayer.Dash.dll => 0x117faaaf => 222
	i32 298918909, ; 44: System.Net.Ping.dll => 0x11d123fd => 69
	i32 317674968, ; 45: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 349
	i32 318968648, ; 46: Xamarin.AndroidX.Activity.dll => 0x13031348 => 237
	i32 321597661, ; 47: System.Numerics => 0x132b30dd => 83
	i32 336156722, ; 48: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 334
	i32 342366114, ; 49: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 269
	i32 356389973, ; 50: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 333
	i32 360082299, ; 51: System.ServiceModel.Web => 0x15766b7b => 131
	i32 364956269, ; 52: Grpc.Net.Common => 0x15c0ca6d => 192
	i32 367780167, ; 53: System.IO.Pipes => 0x15ebe147 => 55
	i32 371306672, ; 54: Grpc.Core.Api.dll => 0x1621b0b0 => 190
	i32 374914964, ; 55: System.Transactions.Local => 0x1658bf94 => 149
	i32 375677976, ; 56: System.Net.ServicePoint.dll => 0x16646418 => 74
	i32 379916513, ; 57: System.Threading.Thread.dll => 0x16a510e1 => 145
	i32 385762202, ; 58: System.Memory.dll => 0x16fe439a => 62
	i32 391886110, ; 59: Grpc.Net.Client.dll => 0x175bb51e => 191
	i32 392610295, ; 60: System.Threading.ThreadPool.dll => 0x1766c1f7 => 146
	i32 395744057, ; 61: _Microsoft.Android.Resource.Designer => 0x17969339 => 356
	i32 403441872, ; 62: WindowsBase => 0x180c08d0 => 165
	i32 435591531, ; 63: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 345
	i32 441335492, ; 64: Xamarin.AndroidX.ConstraintLayout.Core => 0x1a4e3ec4 => 252
	i32 442565967, ; 65: System.Collections => 0x1a61054f => 12
	i32 450948140, ; 66: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 265
	i32 451504562, ; 67: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 125
	i32 452127346, ; 68: ExoPlayer.Database.dll => 0x1af2ea72 => 223
	i32 456227837, ; 69: System.Web.HttpUtility.dll => 0x1b317bfd => 152
	i32 459347974, ; 70: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 113
	i32 465846621, ; 71: mscorlib => 0x1bc4415d => 166
	i32 469710990, ; 72: System.dll => 0x1bff388e => 164
	i32 476646585, ; 73: Xamarin.AndroidX.Interpolator.dll => 0x1c690cb9 => 267
	i32 486930444, ; 74: Xamarin.AndroidX.LocalBroadcastManager.dll => 0x1d05f80c => 280
	i32 498788369, ; 75: System.ObjectModel => 0x1dbae811 => 84
	i32 500358224, ; 76: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 332
	i32 503918385, ; 77: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 326
	i32 513247710, ; 78: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 203
	i32 525008092, ; 79: SkiaSharp.dll => 0x1f4afcdc => 211
	i32 526420162, ; 80: System.Transactions.dll => 0x1f6088c2 => 150
	i32 527452488, ; 81: Xamarin.Kotlin.StdLib.Jdk7 => 0x1f704948 => 315
	i32 530272170, ; 82: System.Linq.Queryable => 0x1f9b4faa => 60
	i32 539058512, ; 83: Microsoft.Extensions.Logging => 0x20216150 => 199
	i32 540030774, ; 84: System.IO.FileSystem.dll => 0x20303736 => 51
	i32 545304856, ; 85: System.Runtime.Extensions => 0x2080b118 => 103
	i32 546455878, ; 86: System.Runtime.Serialization.Xml => 0x20924146 => 114
	i32 548916678, ; 87: Microsoft.Bcl.AsyncInterfaces => 0x20b7cdc6 => 194
	i32 549171840, ; 88: System.Globalization.Calendars => 0x20bbb280 => 40
	i32 557405415, ; 89: Jsr305Binding => 0x213954e7 => 306
	i32 569601784, ; 90: Xamarin.AndroidX.Window.Extensions.Core.Core => 0x21f36ef8 => 304
	i32 577335427, ; 91: System.Security.Cryptography.Cng => 0x22697083 => 120
	i32 592146354, ; 92: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 340
	i32 601371474, ; 93: System.IO.IsolatedStorage.dll => 0x23d83352 => 52
	i32 605376203, ; 94: System.IO.Compression.FileSystem => 0x24154ecb => 44
	i32 613668793, ; 95: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 119
	i32 626887733, ; 96: ExoPlayer.Container => 0x255d8c35 => 220
	i32 627609679, ; 97: Xamarin.AndroidX.CustomView => 0x2568904f => 257
	i32 627931235, ; 98: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 338
	i32 639843206, ; 99: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 0x26233b86 => 263
	i32 643868501, ; 100: System.Net => 0x2660a755 => 81
	i32 646990296, ; 101: Google.Cloud.Firestore.V1.dll => 0x269049d8 => 184
	i32 662205335, ; 102: System.Text.Encodings.Web.dll => 0x27787397 => 136
	i32 663517072, ; 103: Xamarin.AndroidX.VersionedParcelable => 0x278c7790 => 300
	i32 666292255, ; 104: Xamarin.AndroidX.Arch.Core.Common.dll => 0x27b6d01f => 244
	i32 672442732, ; 105: System.Collections.Concurrent => 0x2814a96c => 8
	i32 683518922, ; 106: System.Net.Security => 0x28bdabca => 73
	i32 688181140, ; 107: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 320
	i32 690569205, ; 108: System.Xml.Linq.dll => 0x29293ff5 => 155
	i32 691348768, ; 109: Xamarin.KotlinX.Coroutines.Android.dll => 0x29352520 => 317
	i32 693804605, ; 110: System.Windows => 0x295a9e3d => 154
	i32 699345723, ; 111: System.Reflection.Emit => 0x29af2b3b => 92
	i32 700284507, ; 112: Xamarin.Jetbrains.Annotations => 0x29bd7e5b => 312
	i32 700358131, ; 113: System.IO.Compression.ZipFile => 0x29be9df3 => 45
	i32 706645707, ; 114: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 335
	i32 709557578, ; 115: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 323
	i32 713568204, ; 116: MauiApp1.dll => 0x2a882fcc => 0
	i32 720511267, ; 117: Xamarin.Kotlin.StdLib.Jdk8 => 0x2af22123 => 316
	i32 722857257, ; 118: System.Runtime.Loader.dll => 0x2b15ed29 => 109
	i32 735137430, ; 119: System.Security.SecureString.dll => 0x2bd14e96 => 129
	i32 752232764, ; 120: System.Diagnostics.Contracts.dll => 0x2cd6293c => 25
	i32 755313932, ; 121: Xamarin.Android.Glide.Annotations.dll => 0x2d052d0c => 234
	i32 759454413, ; 122: System.Net.Requests => 0x2d445acd => 72
	i32 762598435, ; 123: System.IO.Pipes.dll => 0x2d745423 => 55
	i32 775507847, ; 124: System.IO.Compression => 0x2e394f87 => 46
	i32 777317022, ; 125: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 344
	i32 789151979, ; 126: Microsoft.Extensions.Options => 0x2f0980eb => 202
	i32 790371945, ; 127: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 0x2f1c1e69 => 258
	i32 804715423, ; 128: System.Data.Common => 0x2ff6fb9f => 22
	i32 807930345, ; 129: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 0x302809e9 => 272
	i32 812693636, ; 130: ExoPlayer.Dash => 0x3070b884 => 222
	i32 823281589, ; 131: System.Private.Uri.dll => 0x311247b5 => 86
	i32 830298997, ; 132: System.IO.Compression.Brotli => 0x317d5b75 => 43
	i32 832635846, ; 133: System.Xml.XPath.dll => 0x31a103c6 => 160
	i32 834051424, ; 134: System.Net.Quic => 0x31b69d60 => 71
	i32 843511501, ; 135: Xamarin.AndroidX.Print => 0x3246f6cd => 286
	i32 873119928, ; 136: Microsoft.VisualBasic => 0x340ac0b8 => 3
	i32 877678880, ; 137: System.Globalization.dll => 0x34505120 => 42
	i32 878954865, ; 138: System.Net.Http.Json => 0x3463c971 => 63
	i32 904024072, ; 139: System.ComponentModel.Primitives.dll => 0x35e25008 => 16
	i32 911108515, ; 140: System.IO.MemoryMappedFiles.dll => 0x364e69a3 => 53
	i32 915551335, ; 141: ExoPlayer.Ext.MediaSession => 0x36923467 => 228
	i32 926902833, ; 142: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 347
	i32 928116545, ; 143: Xamarin.Google.Guava.ListenableFuture => 0x3751ef41 => 311
	i32 939704684, ; 144: ExoPlayer.Extractor => 0x3802c16c => 226
	i32 952186615, ; 145: System.Runtime.InteropServices.JavaScript.dll => 0x38c136f7 => 105
	i32 955402788, ; 146: Newtonsoft.Json => 0x38f24a24 => 210
	i32 956575887, ; 147: Xamarin.Kotlin.StdLib.Jdk8.dll => 0x3904308f => 316
	i32 966729478, ; 148: Xamarin.Google.Crypto.Tink.Android => 0x399f1f06 => 307
	i32 967690846, ; 149: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 269
	i32 975236339, ; 150: System.Diagnostics.Tracing => 0x3a20ecf3 => 34
	i32 975874589, ; 151: System.Xml.XDocument => 0x3a2aaa1d => 158
	i32 986514023, ; 152: System.Private.DataContractSerialization.dll => 0x3acd0267 => 85
	i32 987214855, ; 153: System.Diagnostics.Tools => 0x3ad7b407 => 32
	i32 992768348, ; 154: System.Collections.dll => 0x3b2c715c => 12
	i32 994442037, ; 155: System.IO.FileSystem => 0x3b45fb35 => 51
	i32 1001831731, ; 156: System.IO.UnmanagedMemoryStream.dll => 0x3bb6bd33 => 56
	i32 1012816738, ; 157: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 290
	i32 1019214401, ; 158: System.Drawing => 0x3cbffa41 => 36
	i32 1028013380, ; 159: ExoPlayer.UI.dll => 0x3d463d44 => 232
	i32 1028951442, ; 160: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 198
	i32 1029334545, ; 161: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 322
	i32 1031528504, ; 162: Xamarin.Google.ErrorProne.Annotations.dll => 0x3d7be038 => 308
	i32 1035644815, ; 163: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 242
	i32 1036536393, ; 164: System.Drawing.Primitives.dll => 0x3dc84a49 => 35
	i32 1044663988, ; 165: System.Linq.Expressions.dll => 0x3e444eb4 => 58
	i32 1049751285, ; 166: Google.Api.CommonProtos.dll => 0x3e91eef5 => 176
	i32 1052210849, ; 167: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 276
	i32 1067306892, ; 168: GoogleGson => 0x3f9dcf8c => 188
	i32 1082857460, ; 169: System.ComponentModel.TypeConverter => 0x408b17f4 => 17
	i32 1084122840, ; 170: Xamarin.Kotlin.StdLib => 0x409e66d8 => 313
	i32 1098259244, ; 171: System => 0x41761b2c => 164
	i32 1118262833, ; 172: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 335
	i32 1121599056, ; 173: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 0x42da3e50 => 275
	i32 1127624469, ; 174: Microsoft.Extensions.Logging.Debug => 0x43362f15 => 201
	i32 1145085672, ; 175: System.Linq.Async.dll => 0x44409ee8 => 216
	i32 1149092582, ; 176: Xamarin.AndroidX.Window => 0x447dc2e6 => 303
	i32 1151313727, ; 177: ExoPlayer.Rtsp => 0x449fa73f => 229
	i32 1168523401, ; 178: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 341
	i32 1170634674, ; 179: System.Web.dll => 0x45c677b2 => 153
	i32 1175144683, ; 180: Xamarin.AndroidX.VectorDrawable.Animated => 0x460b48eb => 299
	i32 1178241025, ; 181: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 284
	i32 1203173028, ; 182: Grpc.Net.Client => 0x47b6f6a4 => 191
	i32 1203215381, ; 183: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 339
	i32 1204270330, ; 184: Xamarin.AndroidX.Arch.Core.Common => 0x47c7b4fa => 244
	i32 1208641965, ; 185: System.Diagnostics.Process => 0x480a69ad => 29
	i32 1219128291, ; 186: System.IO.IsolatedStorage => 0x48aa6be3 => 52
	i32 1234928153, ; 187: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 337
	i32 1243150071, ; 188: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 0x4a18f6f7 => 304
	i32 1253011324, ; 189: Microsoft.Win32.Registry => 0x4aaf6f7c => 5
	i32 1260983243, ; 190: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 321
	i32 1263886435, ; 191: Xamarin.Google.Guava.dll => 0x4b556063 => 309
	i32 1264511973, ; 192: Xamarin.AndroidX.Startup.StartupRuntime.dll => 0x4b5eebe5 => 294
	i32 1267360935, ; 193: Xamarin.AndroidX.VectorDrawable => 0x4b8a64a7 => 298
	i32 1273260888, ; 194: Xamarin.AndroidX.Collection.Ktx => 0x4be46b58 => 249
	i32 1275534314, ; 195: Xamarin.KotlinX.Coroutines.Android => 0x4c071bea => 317
	i32 1278448581, ; 196: Xamarin.AndroidX.Annotation.Jvm => 0x4c3393c5 => 241
	i32 1293217323, ; 197: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 260
	i32 1309188875, ; 198: System.Private.DataContractSerialization => 0x4e08a30b => 85
	i32 1309209905, ; 199: ExoPlayer.DataSource => 0x4e08f531 => 224
	i32 1322716291, ; 200: Xamarin.AndroidX.Window.dll => 0x4ed70c83 => 303
	i32 1324164729, ; 201: System.Linq => 0x4eed2679 => 61
	i32 1335329327, ; 202: System.Runtime.Serialization.Json.dll => 0x4f97822f => 112
	i32 1364015309, ; 203: System.IO => 0x514d38cd => 57
	i32 1373134921, ; 204: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 351
	i32 1376866003, ; 205: Xamarin.AndroidX.SavedState => 0x52114ed3 => 290
	i32 1379779777, ; 206: System.Resources.ResourceManager => 0x523dc4c1 => 99
	i32 1395857551, ; 207: Xamarin.AndroidX.Media.dll => 0x5333188f => 281
	i32 1402170036, ; 208: System.Configuration.dll => 0x53936ab4 => 19
	i32 1406073936, ; 209: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 253
	i32 1406299041, ; 210: Xamarin.Google.Guava.FailureAccess => 0x53d26ba1 => 310
	i32 1408764838, ; 211: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 111
	i32 1411638395, ; 212: System.Runtime.CompilerServices.Unsafe => 0x5423e47b => 101
	i32 1422545099, ; 213: System.Runtime.CompilerServices.VisualC => 0x54ca50cb => 102
	i32 1430672901, ; 214: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 319
	i32 1434145427, ; 215: System.Runtime.Handles => 0x557b5293 => 104
	i32 1435222561, ; 216: Xamarin.Google.Crypto.Tink.Android.dll => 0x558bc221 => 307
	i32 1437713837, ; 217: Grpc.Auth => 0x55b1c5ad => 189
	i32 1439761251, ; 218: System.Net.Quic.dll => 0x55d10363 => 71
	i32 1452070440, ; 219: System.Formats.Asn1.dll => 0x568cd628 => 38
	i32 1453312822, ; 220: System.Diagnostics.Tools.dll => 0x569fcb36 => 32
	i32 1457743152, ; 221: System.Runtime.Extensions.dll => 0x56e36530 => 103
	i32 1458022317, ; 222: System.Net.Security.dll => 0x56e7a7ad => 73
	i32 1461004990, ; 223: es\Microsoft.Maui.Controls.resources => 0x57152abe => 325
	i32 1461234159, ; 224: System.Collections.Immutable.dll => 0x5718a9ef => 9
	i32 1461719063, ; 225: System.Security.Cryptography.OpenSsl => 0x57201017 => 123
	i32 1462112819, ; 226: System.IO.Compression.dll => 0x57261233 => 46
	i32 1469204771, ; 227: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 243
	i32 1470490898, ; 228: Microsoft.Extensions.Primitives => 0x57a5e912 => 203
	i32 1479771757, ; 229: System.Collections.Immutable => 0x5833866d => 9
	i32 1480156764, ; 230: ExoPlayer.DataSource.dll => 0x5839665c => 224
	i32 1480492111, ; 231: System.IO.Compression.Brotli.dll => 0x583e844f => 43
	i32 1487239319, ; 232: Microsoft.Win32.Primitives => 0x58a57897 => 4
	i32 1490025113, ; 233: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 0x58cffa99 => 291
	i32 1493001747, ; 234: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 329
	i32 1514721132, ; 235: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 324
	i32 1536373174, ; 236: System.Diagnostics.TextWriterTraceListener => 0x5b9331b6 => 31
	i32 1543031311, ; 237: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 138
	i32 1543355203, ; 238: System.Reflection.Emit.dll => 0x5bfdbb43 => 92
	i32 1550322496, ; 239: System.Reflection.Extensions.dll => 0x5c680b40 => 93
	i32 1551623176, ; 240: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 344
	i32 1565862583, ; 241: System.IO.FileSystem.Primitives => 0x5d552ab7 => 49
	i32 1566207040, ; 242: System.Threading.Tasks.Dataflow.dll => 0x5d5a6c40 => 141
	i32 1573704789, ; 243: System.Runtime.Serialization.Json => 0x5dccd455 => 112
	i32 1580037396, ; 244: System.Threading.Overlapped => 0x5e2d7514 => 140
	i32 1582372066, ; 245: Xamarin.AndroidX.DocumentFile.dll => 0x5e5114e2 => 259
	i32 1592978981, ; 246: System.Runtime.Serialization.dll => 0x5ef2ee25 => 115
	i32 1597949149, ; 247: Xamarin.Google.ErrorProne.Annotations => 0x5f3ec4dd => 308
	i32 1601112923, ; 248: System.Xml.Serialization => 0x5f6f0b5b => 157
	i32 1603525486, ; 249: Microsoft.Maui.Controls.HotReload.Forms.dll => 0x5f93db6e => 353
	i32 1604827217, ; 250: System.Net.WebClient => 0x5fa7b851 => 76
	i32 1618516317, ; 251: System.Net.WebSockets.Client.dll => 0x6078995d => 79
	i32 1622152042, ; 252: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 279
	i32 1622358360, ; 253: System.Dynamic.Runtime => 0x60b33958 => 37
	i32 1623212457, ; 254: SkiaSharp.Views.Maui.Controls => 0x60c041a9 => 213
	i32 1624863272, ; 255: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 302
	i32 1635184631, ; 256: Xamarin.AndroidX.Emoji2.ViewsHelper => 0x6176eff7 => 263
	i32 1636350590, ; 257: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 256
	i32 1638652436, ; 258: CommunityToolkit.Maui.MediaElement => 0x61abda14 => 173
	i32 1639515021, ; 259: System.Net.Http.dll => 0x61b9038d => 64
	i32 1639986890, ; 260: System.Text.RegularExpressions => 0x61c036ca => 138
	i32 1641389582, ; 261: System.ComponentModel.EventBasedAsync.dll => 0x61d59e0e => 15
	i32 1657153582, ; 262: System.Runtime => 0x62c6282e => 116
	i32 1658241508, ; 263: Xamarin.AndroidX.Tracing.Tracing.dll => 0x62d6c1e4 => 296
	i32 1658251792, ; 264: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 305
	i32 1670060433, ; 265: Xamarin.AndroidX.ConstraintLayout => 0x638b1991 => 251
	i32 1675553242, ; 266: System.IO.FileSystem.DriveInfo.dll => 0x63dee9da => 48
	i32 1677501392, ; 267: System.Net.Primitives.dll => 0x63fca3d0 => 70
	i32 1678508291, ; 268: System.Net.WebSockets => 0x640c0103 => 80
	i32 1679769178, ; 269: System.Security.Cryptography => 0x641f3e5a => 126
	i32 1691477237, ; 270: System.Reflection.Metadata => 0x64d1e4f5 => 94
	i32 1696967625, ; 271: System.Security.Cryptography.Csp => 0x6525abc9 => 121
	i32 1698840827, ; 272: Xamarin.Kotlin.StdLib.Common => 0x654240fb => 314
	i32 1700397376, ; 273: ExoPlayer.Transformer => 0x655a0140 => 231
	i32 1701541528, ; 274: System.Diagnostics.Debug.dll => 0x656b7698 => 26
	i32 1720223769, ; 275: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 0x66888819 => 272
	i32 1726116996, ; 276: System.Reflection.dll => 0x66e27484 => 97
	i32 1728033016, ; 277: System.Diagnostics.FileVersionInfo.dll => 0x66ffb0f8 => 28
	i32 1729485958, ; 278: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 247
	i32 1736233607, ; 279: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 342
	i32 1743415430, ; 280: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 320
	i32 1744735666, ; 281: System.Transactions.Local.dll => 0x67fe8db2 => 149
	i32 1746316138, ; 282: Mono.Android.Export => 0x6816ab6a => 169
	i32 1750313021, ; 283: Microsoft.Win32.Primitives.dll => 0x6853a83d => 4
	i32 1758240030, ; 284: System.Resources.Reader.dll => 0x68cc9d1e => 98
	i32 1763938596, ; 285: System.Diagnostics.TraceSource.dll => 0x69239124 => 33
	i32 1765620304, ; 286: ExoPlayer.Core => 0x693d3a50 => 221
	i32 1765942094, ; 287: System.Reflection.Extensions => 0x6942234e => 93
	i32 1766324549, ; 288: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 295
	i32 1770582343, ; 289: Microsoft.Extensions.Logging.dll => 0x6988f147 => 199
	i32 1776026572, ; 290: System.Core.dll => 0x69dc03cc => 21
	i32 1777075843, ; 291: System.Globalization.Extensions.dll => 0x69ec0683 => 41
	i32 1780572499, ; 292: Mono.Android.Runtime.dll => 0x6a216153 => 170
	i32 1782161461, ; 293: Grpc.Core.Api => 0x6a39a035 => 190
	i32 1782862114, ; 294: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 336
	i32 1788241197, ; 295: Xamarin.AndroidX.Fragment => 0x6a96652d => 265
	i32 1793755602, ; 296: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 328
	i32 1796167890, ; 297: Microsoft.Bcl.AsyncInterfaces.dll => 0x6b0f58d2 => 194
	i32 1808609942, ; 298: Xamarin.AndroidX.Loader => 0x6bcd3296 => 279
	i32 1813058853, ; 299: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 313
	i32 1813201214, ; 300: Xamarin.Google.Android.Material => 0x6c13413e => 305
	i32 1818569960, ; 301: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 285
	i32 1818787751, ; 302: Microsoft.VisualBasic.Core => 0x6c687fa7 => 2
	i32 1824175904, ; 303: System.Text.Encoding.Extensions => 0x6cbab720 => 134
	i32 1824722060, ; 304: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 111
	i32 1827303595, ; 305: Microsoft.VisualStudio.DesignTools.TapContract => 0x6cea70ab => 355
	i32 1828688058, ; 306: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 200
	i32 1842015223, ; 307: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 348
	i32 1847515442, ; 308: Xamarin.Android.Glide.Annotations => 0x6e1ed932 => 234
	i32 1853025655, ; 309: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 345
	i32 1858542181, ; 310: System.Linq.Expressions => 0x6ec71a65 => 58
	i32 1870277092, ; 311: System.Reflection.Primitives => 0x6f7a29e4 => 95
	i32 1875935024, ; 312: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 327
	i32 1879696579, ; 313: System.Formats.Tar.dll => 0x7009e4c3 => 39
	i32 1885316902, ; 314: Xamarin.AndroidX.Arch.Core.Runtime.dll => 0x705fa726 => 245
	i32 1885918049, ; 315: Microsoft.VisualStudio.DesignTools.TapContract.dll => 0x7068d361 => 355
	i32 1888955245, ; 316: System.Diagnostics.Contracts => 0x70972b6d => 25
	i32 1889954781, ; 317: System.Reflection.Metadata.dll => 0x70a66bdd => 94
	i32 1898237753, ; 318: System.Reflection.DispatchProxy => 0x7124cf39 => 89
	i32 1900519031, ; 319: Grpc.Auth.dll => 0x71479e77 => 189
	i32 1900610850, ; 320: System.Resources.ResourceManager.dll => 0x71490522 => 99
	i32 1910275211, ; 321: System.Collections.NonGeneric.dll => 0x71dc7c8b => 10
	i32 1926145099, ; 322: ExoPlayer.Container.dll => 0x72cea44b => 220
	i32 1927897671, ; 323: System.CodeDom.dll => 0x72e96247 => 215
	i32 1939592360, ; 324: System.Private.Xml.Linq => 0x739bd4a8 => 87
	i32 1956758971, ; 325: System.Resources.Writer => 0x74a1c5bb => 100
	i32 1961813231, ; 326: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x74eee4ef => 292
	i32 1968388702, ; 327: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 195
	i32 1983156543, ; 328: Xamarin.Kotlin.StdLib.Common.dll => 0x7634913f => 314
	i32 1984283898, ; 329: ExoPlayer.Ext.MediaSession.dll => 0x7645c4fa => 228
	i32 1985761444, ; 330: Xamarin.Android.Glide.GifDecoder => 0x765c50a4 => 236
	i32 2003115576, ; 331: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 324
	i32 2011961780, ; 332: System.Buffers.dll => 0x77ec19b4 => 7
	i32 2019465201, ; 333: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 276
	i32 2025202353, ; 334: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 319
	i32 2031763787, ; 335: Xamarin.Android.Glide => 0x791a414b => 233
	i32 2045470958, ; 336: System.Private.Xml => 0x79eb68ee => 88
	i32 2055257422, ; 337: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 271
	i32 2060060697, ; 338: System.Windows.dll => 0x7aca0819 => 154
	i32 2066184531, ; 339: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 323
	i32 2070888862, ; 340: System.Diagnostics.TraceSource => 0x7b6f419e => 33
	i32 2079903147, ; 341: System.Runtime.dll => 0x7bf8cdab => 116
	i32 2090596640, ; 342: System.Numerics.Vectors => 0x7c9bf920 => 82
	i32 2106312818, ; 343: ExoPlayer.Decoder => 0x7d8bc872 => 225
	i32 2113912252, ; 344: ExoPlayer.UI => 0x7dffbdbc => 232
	i32 2127167465, ; 345: System.Console => 0x7ec9ffe9 => 20
	i32 2142473426, ; 346: System.Collections.Specialized => 0x7fb38cd2 => 11
	i32 2143790110, ; 347: System.Xml.XmlSerializer.dll => 0x7fc7a41e => 162
	i32 2146852085, ; 348: Microsoft.VisualBasic.dll => 0x7ff65cf5 => 3
	i32 2159891885, ; 349: Microsoft.Maui => 0x80bd55ad => 207
	i32 2169148018, ; 350: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 331
	i32 2178612968, ; 351: System.CodeDom => 0x81dafee8 => 215
	i32 2181898931, ; 352: Microsoft.Extensions.Options.dll => 0x820d22b3 => 202
	i32 2188602587, ; 353: Microcharts.Maui => 0x82736cdb => 193
	i32 2192057212, ; 354: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 200
	i32 2193016926, ; 355: System.ObjectModel.dll => 0x82b6c85e => 84
	i32 2201107256, ; 356: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 318
	i32 2201231467, ; 357: System.Net.Http => 0x8334206b => 64
	i32 2202964214, ; 358: ExoPlayer.dll => 0x834e90f6 => 218
	i32 2207618523, ; 359: it\Microsoft.Maui.Controls.resources => 0x839595db => 333
	i32 2217644978, ; 360: Xamarin.AndroidX.VectorDrawable.Animated.dll => 0x842e93b2 => 299
	i32 2222056684, ; 361: System.Threading.Tasks.Parallel => 0x8471e4ec => 143
	i32 2239138732, ; 362: ExoPlayer.SmoothStreaming => 0x85768bac => 230
	i32 2244775296, ; 363: Xamarin.AndroidX.LocalBroadcastManager => 0x85cc8d80 => 280
	i32 2252106437, ; 364: System.Xml.Serialization.dll => 0x863c6ac5 => 157
	i32 2256313426, ; 365: System.Globalization.Extensions => 0x867c9c52 => 41
	i32 2265110946, ; 366: System.Security.AccessControl.dll => 0x8702d9a2 => 117
	i32 2266799131, ; 367: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 196
	i32 2267999099, ; 368: Xamarin.Android.Glide.DiskLruCache.dll => 0x872eeb7b => 235
	i32 2270573516, ; 369: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 327
	i32 2279755925, ; 370: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 288
	i32 2293034957, ; 371: System.ServiceModel.Web.dll => 0x88acefcd => 131
	i32 2295906218, ; 372: System.Net.Sockets => 0x88d8bfaa => 75
	i32 2298471582, ; 373: System.Net.Mail => 0x88ffe49e => 66
	i32 2303942373, ; 374: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 337
	i32 2305521784, ; 375: System.Private.CoreLib.dll => 0x896b7878 => 172
	i32 2315684594, ; 376: Xamarin.AndroidX.Annotation.dll => 0x8a068af2 => 239
	i32 2320631194, ; 377: System.Threading.Tasks.Parallel.dll => 0x8a52059a => 143
	i32 2340441535, ; 378: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 106
	i32 2344264397, ; 379: System.ValueTuple => 0x8bbaa2cd => 151
	i32 2353062107, ; 380: System.Net.Primitives => 0x8c40e0db => 70
	i32 2364201794, ; 381: SkiaSharp.Views.Maui.Core => 0x8ceadb42 => 214
	i32 2368005991, ; 382: System.Xml.ReaderWriter.dll => 0x8d24e767 => 156
	i32 2371007202, ; 383: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 195
	i32 2378619854, ; 384: System.Security.Cryptography.Csp.dll => 0x8dc6dbce => 121
	i32 2383496789, ; 385: System.Security.Principal.Windows.dll => 0x8e114655 => 127
	i32 2395872292, ; 386: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 332
	i32 2397347608, ; 387: Google.LongRunning.dll => 0x8ee49f18 => 186
	i32 2401565422, ; 388: System.Web.HttpUtility => 0x8f24faee => 152
	i32 2403452196, ; 389: Xamarin.AndroidX.Emoji2.dll => 0x8f41c524 => 262
	i32 2409983638, ; 390: Microsoft.VisualStudio.DesignTools.MobileTapContracts.dll => 0x8fa56e96 => 354
	i32 2421380589, ; 391: System.Threading.Tasks.Dataflow => 0x905355ed => 141
	i32 2423080555, ; 392: Xamarin.AndroidX.Collection.Ktx.dll => 0x906d466b => 249
	i32 2427813419, ; 393: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 329
	i32 2435356389, ; 394: System.Console.dll => 0x912896e5 => 20
	i32 2435904999, ; 395: System.ComponentModel.DataAnnotations.dll => 0x9130f5e7 => 14
	i32 2437192331, ; 396: CommunityToolkit.Maui.MediaElement.dll => 0x91449a8b => 173
	i32 2441199521, ; 397: Google.Cloud.Firestore => 0x9181bfa1 => 183
	i32 2454642406, ; 398: System.Text.Encoding.dll => 0x924edee6 => 135
	i32 2458678730, ; 399: System.Net.Sockets.dll => 0x928c75ca => 75
	i32 2459001652, ; 400: System.Linq.Parallel.dll => 0x92916334 => 59
	i32 2465532216, ; 401: Xamarin.AndroidX.ConstraintLayout.Core.dll => 0x92f50938 => 252
	i32 2471841756, ; 402: netstandard.dll => 0x93554fdc => 167
	i32 2475788418, ; 403: Java.Interop.dll => 0x93918882 => 168
	i32 2476233210, ; 404: ExoPlayer => 0x939851fa => 218
	i32 2480646305, ; 405: Microsoft.Maui.Controls => 0x93dba8a1 => 205
	i32 2483903535, ; 406: System.ComponentModel.EventBasedAsync => 0x940d5c2f => 15
	i32 2484371297, ; 407: System.Net.ServicePoint => 0x94147f61 => 74
	i32 2486847491, ; 408: Google.Api.Gax => 0x943a4803 => 177
	i32 2490993605, ; 409: System.AppContext.dll => 0x94798bc5 => 6
	i32 2501346920, ; 410: System.Data.DataSetExtensions => 0x95178668 => 23
	i32 2505896520, ; 411: Xamarin.AndroidX.Lifecycle.Runtime.dll => 0x955cf248 => 274
	i32 2515854816, ; 412: ExoPlayer.Common => 0x95f4e5e0 => 219
	i32 2522472828, ; 413: Xamarin.Android.Glide.dll => 0x9659e17c => 233
	i32 2538310050, ; 414: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 91
	i32 2550873716, ; 415: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 330
	i32 2562349572, ; 416: Microsoft.CSharp => 0x98ba5a04 => 1
	i32 2570120770, ; 417: System.Text.Encodings.Web => 0x9930ee42 => 136
	i32 2581783588, ; 418: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 0x99e2e424 => 275
	i32 2581819634, ; 419: Xamarin.AndroidX.VectorDrawable.dll => 0x99e370f2 => 298
	i32 2585220780, ; 420: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 134
	i32 2585805581, ; 421: System.Net.Ping => 0x9a20430d => 69
	i32 2589602615, ; 422: System.Threading.ThreadPool => 0x9a5a3337 => 146
	i32 2593496499, ; 423: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 339
	i32 2595928349, ; 424: FirebaseAdmin => 0x9abab91d => 174
	i32 2605712449, ; 425: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 318
	i32 2615233544, ; 426: Xamarin.AndroidX.Fragment.Ktx => 0x9be14c08 => 266
	i32 2616218305, ; 427: Microsoft.Extensions.Logging.Debug.dll => 0x9bf052c1 => 201
	i32 2617129537, ; 428: System.Private.Xml.dll => 0x9bfe3a41 => 88
	i32 2618712057, ; 429: System.Reflection.TypeExtensions.dll => 0x9c165ff9 => 96
	i32 2620871830, ; 430: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 256
	i32 2624644809, ; 431: Xamarin.AndroidX.DynamicAnimation => 0x9c70e6c9 => 261
	i32 2625339995, ; 432: SkiaSharp.Views.Maui.Core.dll => 0x9c7b825b => 214
	i32 2626028643, ; 433: ExoPlayer.Rtsp.dll => 0x9c860463 => 229
	i32 2626831493, ; 434: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 334
	i32 2627185994, ; 435: System.Diagnostics.TextWriterTraceListener.dll => 0x9c97ad4a => 31
	i32 2629053246, ; 436: Google.Api.Gax.Rest => 0x9cb42b3e => 179
	i32 2629843544, ; 437: System.IO.Compression.ZipFile.dll => 0x9cc03a58 => 45
	i32 2633051222, ; 438: Xamarin.AndroidX.Lifecycle.LiveData => 0x9cf12c56 => 270
	i32 2635732976, ; 439: Google.Cloud.Firestore.dll => 0x9d1a17f0 => 183
	i32 2663391936, ; 440: Xamarin.Android.Glide.DiskLruCache => 0x9ec022c0 => 235
	i32 2663698177, ; 441: System.Runtime.Loader => 0x9ec4cf01 => 109
	i32 2664396074, ; 442: System.Xml.XDocument.dll => 0x9ecf752a => 158
	i32 2665622720, ; 443: System.Drawing.Primitives => 0x9ee22cc0 => 35
	i32 2676780864, ; 444: System.Data.Common.dll => 0x9f8c6f40 => 22
	i32 2686887180, ; 445: System.Runtime.Serialization.Xml.dll => 0xa026a50c => 114
	i32 2693849962, ; 446: System.IO.dll => 0xa090e36a => 57
	i32 2701096212, ; 447: Xamarin.AndroidX.Tracing.Tracing => 0xa0ff7514 => 296
	i32 2713040075, ; 448: ExoPlayer.Hls => 0xa1b5b4cb => 227
	i32 2715334215, ; 449: System.Threading.Tasks.dll => 0xa1d8b647 => 144
	i32 2717744543, ; 450: System.Security.Claims => 0xa1fd7d9f => 118
	i32 2719963679, ; 451: System.Security.Cryptography.Cng.dll => 0xa21f5a1f => 120
	i32 2724373263, ; 452: System.Runtime.Numerics.dll => 0xa262a30f => 110
	i32 2732626843, ; 453: Xamarin.AndroidX.Activity => 0xa2e0939b => 237
	i32 2735172069, ; 454: System.Threading.Channels => 0xa30769e5 => 139
	i32 2737747696, ; 455: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 243
	i32 2740948882, ; 456: System.IO.Pipes.AccessControl => 0xa35f8f92 => 54
	i32 2744327253, ; 457: Google.Api.Gax.Grpc.dll => 0xa3931c55 => 178
	i32 2748088231, ; 458: System.Runtime.InteropServices.JavaScript => 0xa3cc7fa7 => 105
	i32 2752995522, ; 459: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 340
	i32 2757554483, ; 460: Google.Api.Gax.Grpc => 0xa45cf133 => 178
	i32 2758225723, ; 461: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 206
	i32 2764765095, ; 462: Microsoft.Maui.dll => 0xa4caf7a7 => 207
	i32 2765824710, ; 463: System.Text.Encoding.CodePages.dll => 0xa4db22c6 => 133
	i32 2770495804, ; 464: Xamarin.Jetbrains.Annotations.dll => 0xa522693c => 312
	i32 2778768386, ; 465: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 301
	i32 2779977773, ; 466: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 0xa5b3182d => 289
	i32 2785988530, ; 467: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 346
	i32 2788224221, ; 468: Xamarin.AndroidX.Fragment.Ktx.dll => 0xa630ecdd => 266
	i32 2795602088, ; 469: SkiaSharp.Views.Android.dll => 0xa6a180a8 => 212
	i32 2796087574, ; 470: ExoPlayer.Extractor.dll => 0xa6a8e916 => 226
	i32 2801831435, ; 471: Microsoft.Maui.Graphics => 0xa7008e0b => 209
	i32 2803228030, ; 472: System.Xml.XPath.XDocument.dll => 0xa715dd7e => 159
	i32 2806116107, ; 473: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 325
	i32 2810250172, ; 474: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 253
	i32 2818335264, ; 475: System.Linq.Async => 0xa7fc6220 => 216
	i32 2819470561, ; 476: System.Xml.dll => 0xa80db4e1 => 163
	i32 2821205001, ; 477: System.ServiceProcess.dll => 0xa8282c09 => 132
	i32 2821294376, ; 478: Xamarin.AndroidX.ResourceInspection.Annotation => 0xa8298928 => 289
	i32 2824502124, ; 479: System.Xml.XmlDocument => 0xa85a7b6c => 161
	i32 2831556043, ; 480: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 338
	i32 2838993487, ; 481: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 0xa9379a4f => 277
	i32 2839679515, ; 482: Google.LongRunning => 0xa942121b => 186
	i32 2849599387, ; 483: System.Threading.Overlapped.dll => 0xa9d96f9b => 140
	i32 2853208004, ; 484: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 301
	i32 2855708567, ; 485: Xamarin.AndroidX.Transition => 0xaa36a797 => 297
	i32 2861098320, ; 486: Mono.Android.Export.dll => 0xaa88e550 => 169
	i32 2861189240, ; 487: Microsoft.Maui.Essentials => 0xaa8a4878 => 208
	i32 2870099610, ; 488: Xamarin.AndroidX.Activity.Ktx.dll => 0xab123e9a => 238
	i32 2875164099, ; 489: Jsr305Binding.dll => 0xab5f85c3 => 306
	i32 2875220617, ; 490: System.Globalization.Calendars.dll => 0xab606289 => 40
	i32 2884993177, ; 491: Xamarin.AndroidX.ExifInterface => 0xabf58099 => 264
	i32 2887636118, ; 492: System.Net.dll => 0xac1dd496 => 81
	i32 2893550578, ; 493: Google.Apis.Core => 0xac7813f2 => 182
	i32 2898407901, ; 494: System.Management => 0xacc231dd => 217
	i32 2899753641, ; 495: System.IO.UnmanagedMemoryStream => 0xacd6baa9 => 56
	i32 2900621748, ; 496: System.Dynamic.Runtime.dll => 0xace3f9b4 => 37
	i32 2901442782, ; 497: System.Reflection => 0xacf080de => 97
	i32 2905242038, ; 498: mscorlib.dll => 0xad2a79b6 => 166
	i32 2909740682, ; 499: System.Private.CoreLib => 0xad6f1e8a => 172
	i32 2912489636, ; 500: SkiaSharp.Views.Android => 0xad9910a4 => 212
	i32 2912646636, ; 501: Google.Api.CommonProtos => 0xad9b75ec => 176
	i32 2916838712, ; 502: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 302
	i32 2919462931, ; 503: System.Numerics.Vectors.dll => 0xae037813 => 82
	i32 2921128767, ; 504: Xamarin.AndroidX.Annotation.Experimental.dll => 0xae1ce33f => 240
	i32 2936416060, ; 505: System.Resources.Reader => 0xaf06273c => 98
	i32 2940926066, ; 506: System.Diagnostics.StackTrace.dll => 0xaf4af872 => 30
	i32 2942453041, ; 507: System.Xml.XPath.XDocument => 0xaf624531 => 159
	i32 2959614098, ; 508: System.ComponentModel.dll => 0xb0682092 => 18
	i32 2960379616, ; 509: Xamarin.Google.Guava => 0xb073cee0 => 309
	i32 2968338931, ; 510: System.Security.Principal.Windows => 0xb0ed41f3 => 127
	i32 2972252294, ; 511: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 119
	i32 2978675010, ; 512: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 260
	i32 2987532451, ; 513: Xamarin.AndroidX.Security.SecurityCrypto => 0xb21220a3 => 292
	i32 2990604888, ; 514: Google.Apis => 0xb2410258 => 180
	i32 2996846495, ; 515: Xamarin.AndroidX.Lifecycle.Process.dll => 0xb2a03f9f => 273
	i32 3016983068, ; 516: Xamarin.AndroidX.Startup.StartupRuntime => 0xb3d3821c => 294
	i32 3017953105, ; 517: MauiApp1 => 0xb3e24f51 => 0
	i32 3023353419, ; 518: WindowsBase.dll => 0xb434b64b => 165
	i32 3024354802, ; 519: Xamarin.AndroidX.Legacy.Support.Core.Utils => 0xb443fdf2 => 268
	i32 3027462113, ; 520: ExoPlayer.Common.dll => 0xb47367e1 => 219
	i32 3038032645, ; 521: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 356
	i32 3056245963, ; 522: Xamarin.AndroidX.SavedState.SavedState.Ktx => 0xb62a9ccb => 291
	i32 3057625584, ; 523: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 282
	i32 3059408633, ; 524: Mono.Android.Runtime => 0xb65adef9 => 170
	i32 3059793426, ; 525: System.ComponentModel.Primitives => 0xb660be12 => 16
	i32 3075834255, ; 526: System.Threading.Tasks => 0xb755818f => 144
	i32 3077302341, ; 527: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 331
	i32 3090735792, ; 528: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 125
	i32 3099732863, ; 529: System.Security.Claims.dll => 0xb8c22b7f => 118
	i32 3103600923, ; 530: System.Formats.Asn1 => 0xb8fd311b => 38
	i32 3106263381, ; 531: Grpc.Net.Common.dll => 0xb925d155 => 192
	i32 3111772706, ; 532: System.Runtime.Serialization => 0xb979e222 => 115
	i32 3121463068, ; 533: System.IO.FileSystem.AccessControl.dll => 0xba0dbf1c => 47
	i32 3124832203, ; 534: System.Threading.Tasks.Extensions => 0xba4127cb => 142
	i32 3132293585, ; 535: System.Security.AccessControl => 0xbab301d1 => 117
	i32 3144327419, ; 536: ExoPlayer.Hls.dll => 0xbb6aa0fb => 227
	i32 3147165239, ; 537: System.Diagnostics.Tracing.dll => 0xbb95ee37 => 34
	i32 3148237826, ; 538: GoogleGson.dll => 0xbba64c02 => 188
	i32 3159123045, ; 539: System.Reflection.Primitives.dll => 0xbc4c6465 => 95
	i32 3160747431, ; 540: System.IO.MemoryMappedFiles => 0xbc652da7 => 53
	i32 3178803400, ; 541: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 283
	i32 3190271366, ; 542: ExoPlayer.Decoder.dll => 0xbe27ad86 => 225
	i32 3192346100, ; 543: System.Security.SecureString => 0xbe4755f4 => 129
	i32 3193515020, ; 544: System.Web => 0xbe592c0c => 153
	i32 3203277885, ; 545: Google.Api.Gax.dll => 0xbeee243d => 177
	i32 3204380047, ; 546: System.Data.dll => 0xbefef58f => 24
	i32 3209718065, ; 547: System.Xml.XmlDocument.dll => 0xbf506931 => 161
	i32 3211777861, ; 548: Xamarin.AndroidX.DocumentFile => 0xbf6fd745 => 259
	i32 3220365878, ; 549: System.Threading => 0xbff2e236 => 148
	i32 3226221578, ; 550: System.Runtime.Handles.dll => 0xc04c3c0a => 104
	i32 3251039220, ; 551: System.Reflection.DispatchProxy.dll => 0xc1c6ebf4 => 89
	i32 3258312781, ; 552: Xamarin.AndroidX.CardView => 0xc235e84d => 247
	i32 3265493905, ; 553: System.Linq.Queryable.dll => 0xc2a37b91 => 60
	i32 3265893370, ; 554: System.Threading.Tasks.Extensions.dll => 0xc2a993fa => 142
	i32 3277815716, ; 555: System.Resources.Writer.dll => 0xc35f7fa4 => 100
	i32 3279906254, ; 556: Microsoft.Win32.Registry.dll => 0xc37f65ce => 5
	i32 3280506390, ; 557: System.ComponentModel.Annotations.dll => 0xc3888e16 => 13
	i32 3290767353, ; 558: System.Security.Cryptography.Encoding => 0xc4251ff9 => 122
	i32 3299363146, ; 559: System.Text.Encoding => 0xc4a8494a => 135
	i32 3303498502, ; 560: System.Diagnostics.FileVersionInfo => 0xc4e76306 => 28
	i32 3305363605, ; 561: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 326
	i32 3316684772, ; 562: System.Net.Requests.dll => 0xc5b097e4 => 72
	i32 3317135071, ; 563: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 257
	i32 3317144872, ; 564: System.Data => 0xc5b79d28 => 24
	i32 3329734229, ; 565: ExoPlayer.Database => 0xc677b655 => 223
	i32 3340387945, ; 566: SkiaSharp => 0xc71a4669 => 211
	i32 3340431453, ; 567: Xamarin.AndroidX.Arch.Core.Runtime => 0xc71af05d => 245
	i32 3345895724, ; 568: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 0xc76e512c => 287
	i32 3346324047, ; 569: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 284
	i32 3357674450, ; 570: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 343
	i32 3358260929, ; 571: System.Text.Json => 0xc82afec1 => 137
	i32 3362336904, ; 572: Xamarin.AndroidX.Activity.Ktx => 0xc8693088 => 238
	i32 3362522851, ; 573: Xamarin.AndroidX.Core => 0xc86c06e3 => 254
	i32 3366347497, ; 574: Java.Interop => 0xc8a662e9 => 168
	i32 3374999561, ; 575: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 288
	i32 3381016424, ; 576: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 322
	i32 3395150330, ; 577: System.Runtime.CompilerServices.Unsafe.dll => 0xca5de1fa => 101
	i32 3396979385, ; 578: ExoPlayer.Transformer.dll => 0xca79cab9 => 231
	i32 3403906625, ; 579: System.Security.Cryptography.OpenSsl.dll => 0xcae37e41 => 123
	i32 3405233483, ; 580: Xamarin.AndroidX.CustomView.PoolingContainer => 0xcaf7bd4b => 258
	i32 3428513518, ; 581: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 197
	i32 3429136800, ; 582: System.Xml => 0xcc6479a0 => 163
	i32 3430777524, ; 583: netstandard => 0xcc7d82b4 => 167
	i32 3441283291, ; 584: Xamarin.AndroidX.DynamicAnimation.dll => 0xcd1dd0db => 261
	i32 3445260447, ; 585: System.Formats.Tar => 0xcd5a809f => 39
	i32 3452344032, ; 586: Microsoft.Maui.Controls.Compatibility.dll => 0xcdc696e0 => 204
	i32 3453592554, ; 587: Google.Apis.Core.dll => 0xcdd9a3ea => 182
	i32 3463511458, ; 588: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 330
	i32 3471940407, ; 589: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 17
	i32 3473156932, ; 590: SkiaSharp.Views.Maui.Controls.dll => 0xcf042b44 => 213
	i32 3476120550, ; 591: Mono.Android => 0xcf3163e6 => 171
	i32 3479583265, ; 592: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 343
	i32 3484440000, ; 593: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 342
	i32 3485117614, ; 594: System.Text.Json.dll => 0xcfbaacae => 137
	i32 3486566296, ; 595: System.Transactions => 0xcfd0c798 => 150
	i32 3493954962, ; 596: Xamarin.AndroidX.Concurrent.Futures.dll => 0xd0418592 => 250
	i32 3499097210, ; 597: Google.Protobuf.dll => 0xd08ffc7a => 187
	i32 3509114376, ; 598: System.Xml.Linq => 0xd128d608 => 155
	i32 3515174580, ; 599: System.Security.dll => 0xd1854eb4 => 130
	i32 3530912306, ; 600: System.Configuration => 0xd2757232 => 19
	i32 3539954161, ; 601: System.Net.HttpListener => 0xd2ff69f1 => 65
	i32 3560100363, ; 602: System.Threading.Timer => 0xd432d20b => 147
	i32 3570554715, ; 603: System.IO.FileSystem.AccessControl => 0xd4d2575b => 47
	i32 3580758918, ; 604: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 350
	i32 3597029428, ; 605: Xamarin.Android.Glide.GifDecoder.dll => 0xd6665034 => 236
	i32 3598063517, ; 606: Google.Cloud.Firestore.V1 => 0xd676179d => 184
	i32 3598340787, ; 607: System.Net.WebSockets.Client => 0xd67a52b3 => 79
	i32 3608519521, ; 608: System.Linq.dll => 0xd715a361 => 61
	i32 3612435020, ; 609: System.Management.dll => 0xd751624c => 217
	i32 3621458322, ; 610: Google.Api.Gax.Rest.dll => 0xd7db1192 => 179
	i32 3624195450, ; 611: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 106
	i32 3627220390, ; 612: Xamarin.AndroidX.Print.dll => 0xd832fda6 => 286
	i32 3633644679, ; 613: Xamarin.AndroidX.Annotation.Experimental => 0xd8950487 => 240
	i32 3638274909, ; 614: System.IO.FileSystem.Primitives.dll => 0xd8dbab5d => 49
	i32 3641597786, ; 615: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 271
	i32 3643446276, ; 616: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 347
	i32 3643854240, ; 617: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 283
	i32 3645089577, ; 618: System.ComponentModel.DataAnnotations => 0xd943a729 => 14
	i32 3645630983, ; 619: Google.Protobuf => 0xd94bea07 => 187
	i32 3655481159, ; 620: Firebase.Storage => 0xd9e23747 => 175
	i32 3657292374, ; 621: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 196
	i32 3660523487, ; 622: System.Net.NetworkInformation => 0xda2f27df => 68
	i32 3672681054, ; 623: Mono.Android.dll => 0xdae8aa5e => 171
	i32 3676670898, ; 624: Microsoft.Maui.Controls.HotReload.Forms => 0xdb258bb2 => 353
	i32 3682565725, ; 625: Xamarin.AndroidX.Browser => 0xdb7f7e5d => 246
	i32 3684561358, ; 626: Xamarin.AndroidX.Concurrent.Futures => 0xdb9df1ce => 250
	i32 3697841164, ; 627: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 352
	i32 3700866549, ; 628: System.Net.WebProxy.dll => 0xdc96bdf5 => 78
	i32 3706696989, ; 629: Xamarin.AndroidX.Core.Core.Ktx.dll => 0xdcefb51d => 255
	i32 3716563718, ; 630: System.Runtime.Intrinsics => 0xdd864306 => 108
	i32 3718780102, ; 631: Xamarin.AndroidX.Annotation => 0xdda814c6 => 239
	i32 3724971120, ; 632: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 282
	i32 3732100267, ; 633: System.Net.NameResolution => 0xde7354ab => 67
	i32 3737834244, ; 634: System.Net.Http.Json.dll => 0xdecad304 => 63
	i32 3748608112, ; 635: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 27
	i32 3751444290, ; 636: System.Xml.XPath => 0xdf9a7f42 => 160
	i32 3757995660, ; 637: Google.Cloud.Location.dll => 0xdffe768c => 185
	i32 3786282454, ; 638: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 248
	i32 3792276235, ; 639: System.Collections.NonGeneric => 0xe2098b0b => 10
	i32 3793997468, ; 640: Google.Apis.Auth.dll => 0xe223ce9c => 181
	i32 3800979733, ; 641: Microsoft.Maui.Controls.Compatibility => 0xe28e5915 => 204
	i32 3802395368, ; 642: System.Collections.Specialized.dll => 0xe2a3f2e8 => 11
	i32 3819260425, ; 643: System.Net.WebProxy => 0xe3a54a09 => 78
	i32 3822602673, ; 644: Xamarin.AndroidX.Media => 0xe3d849b1 => 281
	i32 3823082795, ; 645: System.Security.Cryptography.dll => 0xe3df9d2b => 126
	i32 3829621856, ; 646: System.Numerics.dll => 0xe4436460 => 83
	i32 3841636137, ; 647: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 198
	i32 3844307129, ; 648: System.Net.Mail.dll => 0xe52378b9 => 66
	i32 3849253459, ; 649: System.Runtime.InteropServices.dll => 0xe56ef253 => 107
	i32 3870376305, ; 650: System.Net.HttpListener.dll => 0xe6b14171 => 65
	i32 3873536506, ; 651: System.Security.Principal => 0xe6e179fa => 128
	i32 3875112723, ; 652: System.Security.Cryptography.Encoding.dll => 0xe6f98713 => 122
	i32 3885497537, ; 653: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 77
	i32 3885922214, ; 654: Xamarin.AndroidX.Transition.dll => 0xe79e77a6 => 297
	i32 3888767677, ; 655: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 0xe7c9e2bd => 287
	i32 3889960447, ; 656: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 351
	i32 3896106733, ; 657: System.Collections.Concurrent.dll => 0xe839deed => 8
	i32 3896760992, ; 658: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 254
	i32 3901907137, ; 659: Microsoft.VisualBasic.Core.dll => 0xe89260c1 => 2
	i32 3920810846, ; 660: System.IO.Compression.FileSystem.dll => 0xe9b2d35e => 44
	i32 3921031405, ; 661: Xamarin.AndroidX.VersionedParcelable.dll => 0xe9b630ed => 300
	i32 3928044579, ; 662: System.Xml.ReaderWriter => 0xea213423 => 156
	i32 3929187773, ; 663: Firebase.Storage.dll => 0xea32a5bd => 175
	i32 3930554604, ; 664: System.Security.Principal.dll => 0xea4780ec => 128
	i32 3931092270, ; 665: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 285
	i32 3945713374, ; 666: System.Data.DataSetExtensions.dll => 0xeb2ecede => 23
	i32 3953953790, ; 667: System.Text.Encoding.CodePages => 0xebac8bfe => 133
	i32 3955647286, ; 668: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 242
	i32 3959773229, ; 669: Xamarin.AndroidX.Lifecycle.Process => 0xec05582d => 273
	i32 3980434154, ; 670: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 346
	i32 3987592930, ; 671: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 328
	i32 4003436829, ; 672: System.Diagnostics.Process.dll => 0xee9f991d => 29
	i32 4015948917, ; 673: Xamarin.AndroidX.Annotation.Jvm.dll => 0xef5e8475 => 241
	i32 4025784931, ; 674: System.Memory => 0xeff49a63 => 62
	i32 4046471985, ; 675: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 206
	i32 4054681211, ; 676: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 90
	i32 4056144661, ; 677: Google.Cloud.Location => 0xf1c3db15 => 185
	i32 4059682726, ; 678: Google.Apis.dll => 0xf1f9d7a6 => 180
	i32 4068434129, ; 679: System.Private.Xml.Linq.dll => 0xf27f60d1 => 87
	i32 4073602200, ; 680: System.Threading.dll => 0xf2ce3c98 => 148
	i32 4082882467, ; 681: Google.Apis.Auth => 0xf35bd7a3 => 181
	i32 4094352644, ; 682: Microsoft.Maui.Essentials.dll => 0xf40add04 => 208
	i32 4099507663, ; 683: System.Drawing.dll => 0xf45985cf => 36
	i32 4100113165, ; 684: System.Private.Uri => 0xf462c30d => 86
	i32 4101593132, ; 685: Xamarin.AndroidX.Emoji2 => 0xf479582c => 262
	i32 4102112229, ; 686: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 341
	i32 4125707920, ; 687: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 336
	i32 4126470640, ; 688: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 197
	i32 4127667938, ; 689: System.IO.FileSystem.Watcher => 0xf60736e2 => 50
	i32 4130442656, ; 690: System.AppContext => 0xf6318da0 => 6
	i32 4147896353, ; 691: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 90
	i32 4150914736, ; 692: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 348
	i32 4151237749, ; 693: System.Core => 0xf76edc75 => 21
	i32 4159265925, ; 694: System.Xml.XmlSerializer => 0xf7e95c85 => 162
	i32 4161255271, ; 695: System.Reflection.TypeExtensions => 0xf807b767 => 96
	i32 4164802419, ; 696: System.IO.FileSystem.Watcher.dll => 0xf83dd773 => 50
	i32 4173364138, ; 697: ExoPlayer.SmoothStreaming.dll => 0xf8c07baa => 230
	i32 4177102269, ; 698: FirebaseAdmin.dll => 0xf8f985bd => 174
	i32 4181436372, ; 699: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 113
	i32 4182413190, ; 700: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 278
	i32 4182880526, ; 701: Microsoft.VisualStudio.DesignTools.MobileTapContracts => 0xf951b10e => 354
	i32 4185676441, ; 702: System.Security => 0xf97c5a99 => 130
	i32 4189085287, ; 703: Microcharts.Maui.dll => 0xf9b05e67 => 193
	i32 4190597220, ; 704: ExoPlayer.Core.dll => 0xf9c77064 => 221
	i32 4196529839, ; 705: System.Net.WebClient.dll => 0xfa21f6af => 76
	i32 4213026141, ; 706: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 27
	i32 4256097574, ; 707: Xamarin.AndroidX.Core.Core.Ktx => 0xfdaee526 => 255
	i32 4258378803, ; 708: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 0xfdd1b433 => 277
	i32 4260525087, ; 709: System.Buffers => 0xfdf2741f => 7
	i32 4271975918, ; 710: Microsoft.Maui.Controls.dll => 0xfea12dee => 205
	i32 4274976490, ; 711: System.Runtime.Numerics => 0xfecef6ea => 110
	i32 4292120959, ; 712: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 278
	i32 4294763496 ; 713: Xamarin.AndroidX.ExifInterface.dll => 0xfffce3e8 => 264
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [714 x i32] [
	i32 68, ; 0
	i32 67, ; 1
	i32 108, ; 2
	i32 274, ; 3
	i32 311, ; 4
	i32 48, ; 5
	i32 210, ; 6
	i32 80, ; 7
	i32 145, ; 8
	i32 30, ; 9
	i32 352, ; 10
	i32 124, ; 11
	i32 209, ; 12
	i32 102, ; 13
	i32 293, ; 14
	i32 107, ; 15
	i32 293, ; 16
	i32 139, ; 17
	i32 315, ; 18
	i32 77, ; 19
	i32 124, ; 20
	i32 13, ; 21
	i32 248, ; 22
	i32 132, ; 23
	i32 295, ; 24
	i32 151, ; 25
	i32 349, ; 26
	i32 350, ; 27
	i32 18, ; 28
	i32 246, ; 29
	i32 26, ; 30
	i32 268, ; 31
	i32 1, ; 32
	i32 59, ; 33
	i32 42, ; 34
	i32 91, ; 35
	i32 251, ; 36
	i32 310, ; 37
	i32 147, ; 38
	i32 270, ; 39
	i32 267, ; 40
	i32 321, ; 41
	i32 54, ; 42
	i32 222, ; 43
	i32 69, ; 44
	i32 349, ; 45
	i32 237, ; 46
	i32 83, ; 47
	i32 334, ; 48
	i32 269, ; 49
	i32 333, ; 50
	i32 131, ; 51
	i32 192, ; 52
	i32 55, ; 53
	i32 190, ; 54
	i32 149, ; 55
	i32 74, ; 56
	i32 145, ; 57
	i32 62, ; 58
	i32 191, ; 59
	i32 146, ; 60
	i32 356, ; 61
	i32 165, ; 62
	i32 345, ; 63
	i32 252, ; 64
	i32 12, ; 65
	i32 265, ; 66
	i32 125, ; 67
	i32 223, ; 68
	i32 152, ; 69
	i32 113, ; 70
	i32 166, ; 71
	i32 164, ; 72
	i32 267, ; 73
	i32 280, ; 74
	i32 84, ; 75
	i32 332, ; 76
	i32 326, ; 77
	i32 203, ; 78
	i32 211, ; 79
	i32 150, ; 80
	i32 315, ; 81
	i32 60, ; 82
	i32 199, ; 83
	i32 51, ; 84
	i32 103, ; 85
	i32 114, ; 86
	i32 194, ; 87
	i32 40, ; 88
	i32 306, ; 89
	i32 304, ; 90
	i32 120, ; 91
	i32 340, ; 92
	i32 52, ; 93
	i32 44, ; 94
	i32 119, ; 95
	i32 220, ; 96
	i32 257, ; 97
	i32 338, ; 98
	i32 263, ; 99
	i32 81, ; 100
	i32 184, ; 101
	i32 136, ; 102
	i32 300, ; 103
	i32 244, ; 104
	i32 8, ; 105
	i32 73, ; 106
	i32 320, ; 107
	i32 155, ; 108
	i32 317, ; 109
	i32 154, ; 110
	i32 92, ; 111
	i32 312, ; 112
	i32 45, ; 113
	i32 335, ; 114
	i32 323, ; 115
	i32 0, ; 116
	i32 316, ; 117
	i32 109, ; 118
	i32 129, ; 119
	i32 25, ; 120
	i32 234, ; 121
	i32 72, ; 122
	i32 55, ; 123
	i32 46, ; 124
	i32 344, ; 125
	i32 202, ; 126
	i32 258, ; 127
	i32 22, ; 128
	i32 272, ; 129
	i32 222, ; 130
	i32 86, ; 131
	i32 43, ; 132
	i32 160, ; 133
	i32 71, ; 134
	i32 286, ; 135
	i32 3, ; 136
	i32 42, ; 137
	i32 63, ; 138
	i32 16, ; 139
	i32 53, ; 140
	i32 228, ; 141
	i32 347, ; 142
	i32 311, ; 143
	i32 226, ; 144
	i32 105, ; 145
	i32 210, ; 146
	i32 316, ; 147
	i32 307, ; 148
	i32 269, ; 149
	i32 34, ; 150
	i32 158, ; 151
	i32 85, ; 152
	i32 32, ; 153
	i32 12, ; 154
	i32 51, ; 155
	i32 56, ; 156
	i32 290, ; 157
	i32 36, ; 158
	i32 232, ; 159
	i32 198, ; 160
	i32 322, ; 161
	i32 308, ; 162
	i32 242, ; 163
	i32 35, ; 164
	i32 58, ; 165
	i32 176, ; 166
	i32 276, ; 167
	i32 188, ; 168
	i32 17, ; 169
	i32 313, ; 170
	i32 164, ; 171
	i32 335, ; 172
	i32 275, ; 173
	i32 201, ; 174
	i32 216, ; 175
	i32 303, ; 176
	i32 229, ; 177
	i32 341, ; 178
	i32 153, ; 179
	i32 299, ; 180
	i32 284, ; 181
	i32 191, ; 182
	i32 339, ; 183
	i32 244, ; 184
	i32 29, ; 185
	i32 52, ; 186
	i32 337, ; 187
	i32 304, ; 188
	i32 5, ; 189
	i32 321, ; 190
	i32 309, ; 191
	i32 294, ; 192
	i32 298, ; 193
	i32 249, ; 194
	i32 317, ; 195
	i32 241, ; 196
	i32 260, ; 197
	i32 85, ; 198
	i32 224, ; 199
	i32 303, ; 200
	i32 61, ; 201
	i32 112, ; 202
	i32 57, ; 203
	i32 351, ; 204
	i32 290, ; 205
	i32 99, ; 206
	i32 281, ; 207
	i32 19, ; 208
	i32 253, ; 209
	i32 310, ; 210
	i32 111, ; 211
	i32 101, ; 212
	i32 102, ; 213
	i32 319, ; 214
	i32 104, ; 215
	i32 307, ; 216
	i32 189, ; 217
	i32 71, ; 218
	i32 38, ; 219
	i32 32, ; 220
	i32 103, ; 221
	i32 73, ; 222
	i32 325, ; 223
	i32 9, ; 224
	i32 123, ; 225
	i32 46, ; 226
	i32 243, ; 227
	i32 203, ; 228
	i32 9, ; 229
	i32 224, ; 230
	i32 43, ; 231
	i32 4, ; 232
	i32 291, ; 233
	i32 329, ; 234
	i32 324, ; 235
	i32 31, ; 236
	i32 138, ; 237
	i32 92, ; 238
	i32 93, ; 239
	i32 344, ; 240
	i32 49, ; 241
	i32 141, ; 242
	i32 112, ; 243
	i32 140, ; 244
	i32 259, ; 245
	i32 115, ; 246
	i32 308, ; 247
	i32 157, ; 248
	i32 353, ; 249
	i32 76, ; 250
	i32 79, ; 251
	i32 279, ; 252
	i32 37, ; 253
	i32 213, ; 254
	i32 302, ; 255
	i32 263, ; 256
	i32 256, ; 257
	i32 173, ; 258
	i32 64, ; 259
	i32 138, ; 260
	i32 15, ; 261
	i32 116, ; 262
	i32 296, ; 263
	i32 305, ; 264
	i32 251, ; 265
	i32 48, ; 266
	i32 70, ; 267
	i32 80, ; 268
	i32 126, ; 269
	i32 94, ; 270
	i32 121, ; 271
	i32 314, ; 272
	i32 231, ; 273
	i32 26, ; 274
	i32 272, ; 275
	i32 97, ; 276
	i32 28, ; 277
	i32 247, ; 278
	i32 342, ; 279
	i32 320, ; 280
	i32 149, ; 281
	i32 169, ; 282
	i32 4, ; 283
	i32 98, ; 284
	i32 33, ; 285
	i32 221, ; 286
	i32 93, ; 287
	i32 295, ; 288
	i32 199, ; 289
	i32 21, ; 290
	i32 41, ; 291
	i32 170, ; 292
	i32 190, ; 293
	i32 336, ; 294
	i32 265, ; 295
	i32 328, ; 296
	i32 194, ; 297
	i32 279, ; 298
	i32 313, ; 299
	i32 305, ; 300
	i32 285, ; 301
	i32 2, ; 302
	i32 134, ; 303
	i32 111, ; 304
	i32 355, ; 305
	i32 200, ; 306
	i32 348, ; 307
	i32 234, ; 308
	i32 345, ; 309
	i32 58, ; 310
	i32 95, ; 311
	i32 327, ; 312
	i32 39, ; 313
	i32 245, ; 314
	i32 355, ; 315
	i32 25, ; 316
	i32 94, ; 317
	i32 89, ; 318
	i32 189, ; 319
	i32 99, ; 320
	i32 10, ; 321
	i32 220, ; 322
	i32 215, ; 323
	i32 87, ; 324
	i32 100, ; 325
	i32 292, ; 326
	i32 195, ; 327
	i32 314, ; 328
	i32 228, ; 329
	i32 236, ; 330
	i32 324, ; 331
	i32 7, ; 332
	i32 276, ; 333
	i32 319, ; 334
	i32 233, ; 335
	i32 88, ; 336
	i32 271, ; 337
	i32 154, ; 338
	i32 323, ; 339
	i32 33, ; 340
	i32 116, ; 341
	i32 82, ; 342
	i32 225, ; 343
	i32 232, ; 344
	i32 20, ; 345
	i32 11, ; 346
	i32 162, ; 347
	i32 3, ; 348
	i32 207, ; 349
	i32 331, ; 350
	i32 215, ; 351
	i32 202, ; 352
	i32 193, ; 353
	i32 200, ; 354
	i32 84, ; 355
	i32 318, ; 356
	i32 64, ; 357
	i32 218, ; 358
	i32 333, ; 359
	i32 299, ; 360
	i32 143, ; 361
	i32 230, ; 362
	i32 280, ; 363
	i32 157, ; 364
	i32 41, ; 365
	i32 117, ; 366
	i32 196, ; 367
	i32 235, ; 368
	i32 327, ; 369
	i32 288, ; 370
	i32 131, ; 371
	i32 75, ; 372
	i32 66, ; 373
	i32 337, ; 374
	i32 172, ; 375
	i32 239, ; 376
	i32 143, ; 377
	i32 106, ; 378
	i32 151, ; 379
	i32 70, ; 380
	i32 214, ; 381
	i32 156, ; 382
	i32 195, ; 383
	i32 121, ; 384
	i32 127, ; 385
	i32 332, ; 386
	i32 186, ; 387
	i32 152, ; 388
	i32 262, ; 389
	i32 354, ; 390
	i32 141, ; 391
	i32 249, ; 392
	i32 329, ; 393
	i32 20, ; 394
	i32 14, ; 395
	i32 173, ; 396
	i32 183, ; 397
	i32 135, ; 398
	i32 75, ; 399
	i32 59, ; 400
	i32 252, ; 401
	i32 167, ; 402
	i32 168, ; 403
	i32 218, ; 404
	i32 205, ; 405
	i32 15, ; 406
	i32 74, ; 407
	i32 177, ; 408
	i32 6, ; 409
	i32 23, ; 410
	i32 274, ; 411
	i32 219, ; 412
	i32 233, ; 413
	i32 91, ; 414
	i32 330, ; 415
	i32 1, ; 416
	i32 136, ; 417
	i32 275, ; 418
	i32 298, ; 419
	i32 134, ; 420
	i32 69, ; 421
	i32 146, ; 422
	i32 339, ; 423
	i32 174, ; 424
	i32 318, ; 425
	i32 266, ; 426
	i32 201, ; 427
	i32 88, ; 428
	i32 96, ; 429
	i32 256, ; 430
	i32 261, ; 431
	i32 214, ; 432
	i32 229, ; 433
	i32 334, ; 434
	i32 31, ; 435
	i32 179, ; 436
	i32 45, ; 437
	i32 270, ; 438
	i32 183, ; 439
	i32 235, ; 440
	i32 109, ; 441
	i32 158, ; 442
	i32 35, ; 443
	i32 22, ; 444
	i32 114, ; 445
	i32 57, ; 446
	i32 296, ; 447
	i32 227, ; 448
	i32 144, ; 449
	i32 118, ; 450
	i32 120, ; 451
	i32 110, ; 452
	i32 237, ; 453
	i32 139, ; 454
	i32 243, ; 455
	i32 54, ; 456
	i32 178, ; 457
	i32 105, ; 458
	i32 340, ; 459
	i32 178, ; 460
	i32 206, ; 461
	i32 207, ; 462
	i32 133, ; 463
	i32 312, ; 464
	i32 301, ; 465
	i32 289, ; 466
	i32 346, ; 467
	i32 266, ; 468
	i32 212, ; 469
	i32 226, ; 470
	i32 209, ; 471
	i32 159, ; 472
	i32 325, ; 473
	i32 253, ; 474
	i32 216, ; 475
	i32 163, ; 476
	i32 132, ; 477
	i32 289, ; 478
	i32 161, ; 479
	i32 338, ; 480
	i32 277, ; 481
	i32 186, ; 482
	i32 140, ; 483
	i32 301, ; 484
	i32 297, ; 485
	i32 169, ; 486
	i32 208, ; 487
	i32 238, ; 488
	i32 306, ; 489
	i32 40, ; 490
	i32 264, ; 491
	i32 81, ; 492
	i32 182, ; 493
	i32 217, ; 494
	i32 56, ; 495
	i32 37, ; 496
	i32 97, ; 497
	i32 166, ; 498
	i32 172, ; 499
	i32 212, ; 500
	i32 176, ; 501
	i32 302, ; 502
	i32 82, ; 503
	i32 240, ; 504
	i32 98, ; 505
	i32 30, ; 506
	i32 159, ; 507
	i32 18, ; 508
	i32 309, ; 509
	i32 127, ; 510
	i32 119, ; 511
	i32 260, ; 512
	i32 292, ; 513
	i32 180, ; 514
	i32 273, ; 515
	i32 294, ; 516
	i32 0, ; 517
	i32 165, ; 518
	i32 268, ; 519
	i32 219, ; 520
	i32 356, ; 521
	i32 291, ; 522
	i32 282, ; 523
	i32 170, ; 524
	i32 16, ; 525
	i32 144, ; 526
	i32 331, ; 527
	i32 125, ; 528
	i32 118, ; 529
	i32 38, ; 530
	i32 192, ; 531
	i32 115, ; 532
	i32 47, ; 533
	i32 142, ; 534
	i32 117, ; 535
	i32 227, ; 536
	i32 34, ; 537
	i32 188, ; 538
	i32 95, ; 539
	i32 53, ; 540
	i32 283, ; 541
	i32 225, ; 542
	i32 129, ; 543
	i32 153, ; 544
	i32 177, ; 545
	i32 24, ; 546
	i32 161, ; 547
	i32 259, ; 548
	i32 148, ; 549
	i32 104, ; 550
	i32 89, ; 551
	i32 247, ; 552
	i32 60, ; 553
	i32 142, ; 554
	i32 100, ; 555
	i32 5, ; 556
	i32 13, ; 557
	i32 122, ; 558
	i32 135, ; 559
	i32 28, ; 560
	i32 326, ; 561
	i32 72, ; 562
	i32 257, ; 563
	i32 24, ; 564
	i32 223, ; 565
	i32 211, ; 566
	i32 245, ; 567
	i32 287, ; 568
	i32 284, ; 569
	i32 343, ; 570
	i32 137, ; 571
	i32 238, ; 572
	i32 254, ; 573
	i32 168, ; 574
	i32 288, ; 575
	i32 322, ; 576
	i32 101, ; 577
	i32 231, ; 578
	i32 123, ; 579
	i32 258, ; 580
	i32 197, ; 581
	i32 163, ; 582
	i32 167, ; 583
	i32 261, ; 584
	i32 39, ; 585
	i32 204, ; 586
	i32 182, ; 587
	i32 330, ; 588
	i32 17, ; 589
	i32 213, ; 590
	i32 171, ; 591
	i32 343, ; 592
	i32 342, ; 593
	i32 137, ; 594
	i32 150, ; 595
	i32 250, ; 596
	i32 187, ; 597
	i32 155, ; 598
	i32 130, ; 599
	i32 19, ; 600
	i32 65, ; 601
	i32 147, ; 602
	i32 47, ; 603
	i32 350, ; 604
	i32 236, ; 605
	i32 184, ; 606
	i32 79, ; 607
	i32 61, ; 608
	i32 217, ; 609
	i32 179, ; 610
	i32 106, ; 611
	i32 286, ; 612
	i32 240, ; 613
	i32 49, ; 614
	i32 271, ; 615
	i32 347, ; 616
	i32 283, ; 617
	i32 14, ; 618
	i32 187, ; 619
	i32 175, ; 620
	i32 196, ; 621
	i32 68, ; 622
	i32 171, ; 623
	i32 353, ; 624
	i32 246, ; 625
	i32 250, ; 626
	i32 352, ; 627
	i32 78, ; 628
	i32 255, ; 629
	i32 108, ; 630
	i32 239, ; 631
	i32 282, ; 632
	i32 67, ; 633
	i32 63, ; 634
	i32 27, ; 635
	i32 160, ; 636
	i32 185, ; 637
	i32 248, ; 638
	i32 10, ; 639
	i32 181, ; 640
	i32 204, ; 641
	i32 11, ; 642
	i32 78, ; 643
	i32 281, ; 644
	i32 126, ; 645
	i32 83, ; 646
	i32 198, ; 647
	i32 66, ; 648
	i32 107, ; 649
	i32 65, ; 650
	i32 128, ; 651
	i32 122, ; 652
	i32 77, ; 653
	i32 297, ; 654
	i32 287, ; 655
	i32 351, ; 656
	i32 8, ; 657
	i32 254, ; 658
	i32 2, ; 659
	i32 44, ; 660
	i32 300, ; 661
	i32 156, ; 662
	i32 175, ; 663
	i32 128, ; 664
	i32 285, ; 665
	i32 23, ; 666
	i32 133, ; 667
	i32 242, ; 668
	i32 273, ; 669
	i32 346, ; 670
	i32 328, ; 671
	i32 29, ; 672
	i32 241, ; 673
	i32 62, ; 674
	i32 206, ; 675
	i32 90, ; 676
	i32 185, ; 677
	i32 180, ; 678
	i32 87, ; 679
	i32 148, ; 680
	i32 181, ; 681
	i32 208, ; 682
	i32 36, ; 683
	i32 86, ; 684
	i32 262, ; 685
	i32 341, ; 686
	i32 336, ; 687
	i32 197, ; 688
	i32 50, ; 689
	i32 6, ; 690
	i32 90, ; 691
	i32 348, ; 692
	i32 21, ; 693
	i32 162, ; 694
	i32 96, ; 695
	i32 50, ; 696
	i32 230, ; 697
	i32 174, ; 698
	i32 113, ; 699
	i32 278, ; 700
	i32 354, ; 701
	i32 130, ; 702
	i32 193, ; 703
	i32 221, ; 704
	i32 76, ; 705
	i32 27, ; 706
	i32 255, ; 707
	i32 277, ; 708
	i32 7, ; 709
	i32 205, ; 710
	i32 110, ; 711
	i32 278, ; 712
	i32 264 ; 713
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.4xx @ 82d8938cf80f6d5fa6c28529ddfbdb753d805ab4"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"min_enum_size", i32 4}
