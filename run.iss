[Run]
;Support Software
Filename: "{src}\redist\dxwebsetup.exe";   Parameters: "/q"; StatusMsg: "Install Microsoft DirectX online...";     Check: CheckError; Tasks: DirectX;      Flags: skipifdoesntexist
Filename: "{src}\redist\vcredist_x86.exe"; Parameters: "/q"; StatusMsg: "Install Microsoft Visual C++ Redist...";  Check: CheckError; Tasks: MVCppRedist;  Flags: skipifdoesntexist
Filename: "{src}\redist\vcredist_x64.exe"; Parameters: "/q"; StatusMsg: "Install Microsoft Visual C++ Redist...";  Check: CheckError; Tasks: MVCppRedist;  Flags: skipifdoesntexist