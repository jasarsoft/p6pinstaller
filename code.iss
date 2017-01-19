[Code]
//Types
type
  TCallback = function (OveralPct,CurrentPct: integer;CurrentFile,TimeStr1,TimeStr2,TimeStr3:PAnsiChar): longword;

//Variables
var ISDoneProgressBarMain:    TNewProgressBar;
    
    LabelProgressBarPercent:  TLabel;
    LabelExtractFileName:     TLabel;
    LabelElapsedTime:         TLabel;
    LabelRemainingTime:       TLabel;
    //Welcome label
    LabelWelcomeTitleName:    TLabel;
    LabelWelcomeTitleSeason:  TLabel;
    //Finish label
    LabelFinishedTitle:       TLabel;
    LabelFinishedSubTitle:    TLabel;
    LabelFinishedText:        TLabel;
    LabelFinishedSubText:     TLabel;
    //Image
    BitmapImageWebsite:        TBitmapImage;
    
    MyCancelButton:           TButton;
    
    ISDoneCancel:             Integer;
    ISDoneError:              Boolean;
    
    LabelName, LabelType, LabelSeason, LabelLanguage, LabelDeveloper, LabelDescription: TLabel;

//Archive Percent
var intSoundPack:           Integer;
    intKitserverPack:       Integer;
    intBallsPack:           Integer;
    intBootsPack:           Integer;
    intFacesPack:           Integer;
    intHairPack:            Integer;
    intStadiumsPack:        Integer;
    intUniPack:             Integer;


var   LabelInfoName:        TLabel;
      LabelInfoType:        TLabel;
      LabelInfoSeason:      TLabel;
      LabelInfoLanguage:    TLabel;
      LabelInfoDeveloper:   TLabel;
      LabelInfoDescription: TLabel;

var   LabelInfoNameSub:         TLabel;
      LabelInfoTypeSub:         TLabel;
      LabelInfoSeasonSub:       TLabel;
      LabelInfoLanguageSub:     TLabel;
      LabelInfoDeveloperSub:    TLabel;
      LabelInfoDescriptionSub:  TLabel;


//Functions
function ISArcExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutPath, ExtractedPath: AnsiString; DeleteInFile:boolean; Password, CfgFile, WorkPath: AnsiString; ExtractPCF: boolean ):boolean; external 'ISArcExtract@files:ISDone.dll stdcall delayload';
function IS7ZipExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutPath: AnsiString; DeleteInFile:boolean; Password: AnsiString):boolean; external 'IS7zipExtract@files:ISDone.dll stdcall delayload';
function ISRarExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutPath: AnsiString; DeleteInFile:boolean; Password: AnsiString):boolean; external 'ISRarExtract@files:ISDone.dll stdcall delayload';
function ISPrecompExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutFile: AnsiString; DeleteInFile:boolean):boolean; external 'ISPrecompExtract@files:ISDone.dll stdcall delayload';
function ISSRepExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutFile: AnsiString; DeleteInFile:boolean):boolean; external 'ISSrepExtract@files:ISDone.dll stdcall delayload';
function ISxDeltaExtract(CurComponent:Cardinal; PctOfTotal:double; minRAM,maxRAM:integer; InName, DiffFile, OutFile: AnsiString; DeleteInFile:boolean):boolean; external 'ISxDeltaExtract@files:ISDone.dll stdcall delayload';
function ISPackZIP(CurComponent:Cardinal; PctOfTotal:double; InName, OutFile: AnsiString;ComprLvl:integer; DeleteInFile:boolean):boolean; external 'ISPackZIP@files:ISDone.dll stdcall delayload';
function ShowChangeDiskWindow(Text, DefaultPath, SearchFile:AnsiString):boolean; external 'ShowChangeDiskWindow@files:ISDone.dll stdcall delayload';

function Exec2 (FileName, Param: PAnsiChar;Show:boolean):boolean; external 'Exec2@files:ISDone.dll stdcall delayload';
function ISFindFiles(CurComponent:Cardinal; FileMask:AnsiString; var ColFiles:integer):integer; external 'ISFindFiles@files:ISDone.dll stdcall delayload';
function ISPickFilename(FindHandle:integer; OutPath:AnsiString; var CurIndex:integer; DeleteInFile:boolean):boolean; external 'ISPickFilename@files:ISDone.dll stdcall delayload';
function ISGetName(TypeStr:integer):PAnsichar; external 'ISGetName@files:ISDone.dll stdcall delayload';
function ISFindFree(FindHandle:integer):boolean; external 'ISFindFree@files:ISDone.dll stdcall delayload';
function ISExec(CurComponent:Cardinal; PctOfTotal,SpecifiedProcessTime:double; ExeName,Parameters,TargetDir,OutputStr:AnsiString;Show:boolean):boolean; external 'ISExec@files:ISDone.dll stdcall delayload';

function SrepInit(TmpPath:PAnsiChar;VirtMem,MaxSave:Cardinal):boolean; external 'SrepInit@files:ISDone.dll stdcall delayload';
function PrecompInit(TmpPath:PAnsiChar;VirtMem:cardinal;PrecompVers:single):boolean; external 'PrecompInit@files:ISDone.dll stdcall delayload';
function FileSearchInit(RecursiveSubDir:boolean):boolean; external 'FileSearchInit@files:ISDone.dll stdcall delayload';
function ISDoneInit(RecordFileName:AnsiString; TimeType,Comp1,Comp2,Comp3:Cardinal; WinHandle, NeededMem:longint; callback:TCallback):boolean; external 'ISDoneInit@files:ISDone.dll stdcall';
function ISDoneStop:boolean; external 'ISDoneStop@files:ISDone.dll stdcall';
function ChangeLanguage(Language:AnsiString):boolean; external 'ChangeLanguage@files:ISDone.dll stdcall delayload';
function SuspendProc:boolean; external 'SuspendProc@files:ISDone.dll stdcall';
function ResumeProc:boolean; external 'ResumeProc@files:ISDone.dll stdcall';

function FindWindow(lpClassName, lpWindowName: PAnsiChar): HWND; external 'FindWindowA@user32.dll stdcall';
function EnableWindow(hWnd: HWND; bEnable: BOOL): BOOL; external 'EnableWindow@user32.dll stdcall';

procedure LoadSkin(lpszPath: PAnsiChar; lpszIniFileName: PAnsiChar); external 'LoadSkin@{tmp}\isskin.dll stdcall delayload';
procedure UnloadSkin; external 'UnloadSkin@{tmp}\isskin.dll stdcall delayload';


function FindWindowByName(Text: PAnsiChar): HWND;
begin
  Result:= FindWindow('#32770', ExpandConstant(Text))
end;


function ProgressCallback(OveralPct,CurrentPct: Integer;CurrentFile,TimeStr1,TimeStr2,TimeStr3:PAnsiChar): LongWord;
var msgwnd: HWND; 
begin
  msgwnd:= FindWindowByName('ISDone.dll');
  
  if msgwnd <> 0 then begin
    EnableWindow(WizardForm.Handle, False) 
    end
  else begin 
    EnableWindow(WizardForm.Handle, True);
  end;

  if OveralPct <= 1000 then begin 
    ISDoneProgressBarMain.Position := OveralPct;
  end;

  if msgwnd = 0 then begin
    LabelProgressBarPercent.Caption := IntToStr(OveralPct div 10) + '.' + chr(48 + OveralPct mod 10) + '%' 
    end
  else begin 
    LabelProgressBarPercent.Caption:= '0%';
  end;

  if msgwnd = 0 then begin
    LabelExtractFileName.Caption := ExpandConstant('{cm:ExtractedFile} ') + MinimizePathName(CurrentFile, LabelExtractFileName.Font, LabelExtractFileName.Width-ScaleX(100)); 
    end
  else begin 
    LabelExtractFileName.Caption:= ExpandConstant('{cm:ScanFile}');
  end;
  
  if msgwnd = 0 then begin
    LabelElapsedTime.Caption := ExpandConstant('{cm:ElapsedTime} ') + TimeStr2;
    end
  else begin 
    LabelElapsedTime.Caption := ExpandConstant('{cm:ElapsedTime} {cm:TimeError}');
  end;

  if msgwnd = 0 then begin 
    LabelRemainingTime.Caption := ExpandConstant('{cm:RemainingTime} ') + TimeStr1;
    end 
  else begin 
    LabelRemainingTime.Caption := ExpandConstant('{cm:RemainingTime} {cm:TimeError}');
  end;
  
  Result := ISDoneCancel;
end;


procedure CancelButtonOnClick(Sender: TObject);
begin
  SuspendProc;
  if MsgBox(SetupMessage(msgExitSetupMessage), mbConfirmation, MB_YESNO) = IDYES then ISDoneCancel:=1;
  ResumeProc;
end;

procedure Website(Sender: TObject);
  var
    ErrCode: integer;
begin
    begin
        ShellExec('open', 'http://www.evo-web.co.uk/forums/showthread.php?t=73875', '', '', SW_SHOW, ewNoWait, ErrCode);
    end;
end;



procedure HideControls;
begin
  WizardForm.FileNameLabel.Hide;
  ISDoneProgressBarMain.Hide;
  LabelProgressBarPercent.Hide;
  LabelExtractFileName.Hide;
  LabelElapsedTime.Hide;
  LabelRemainingTime.Hide;
  MyCancelButton.Hide;
end;

procedure CreateControls;
begin
  //ProgressBar
  ISDoneProgressBarMain           := TNewProgressBar.Create(WizardForm);
  ISDoneProgressBarMain.Parent    := WizardForm.InstallingPage;
  ISDoneProgressBarMain.Left      := WizardForm.ProgressGauge.Left;
  ISDoneProgressBarMain.Top       := WizardForm.ProgressGauge.Top + ScaleY(5);
  ISDoneProgressBarMain.Height    := WizardForm.ProgressGauge.Height;
  ISDoneProgressBarMain.Width     := WizardForm.ProgressGauge.Width;
  ISDoneProgressBarMain.Max       := 1000;
  //Percent
  LabelProgressBarPercent           := TLabel.Create(WizardForm);
  LabelProgressBarPercent.Parent    := WizardForm.InstallingPage;
  LabelProgressBarPercent.Left      := ISDoneProgressBarMain.Width - ScaleX(50);
  LabelProgressBarPercent.Top       := ISDoneProgressBarMain.Top - ScaleY(18);
  LabelProgressBarPercent.Width     := ScaleX(50);
  LabelProgressBarPercent.Height    := ScaleY(18);
  LabelProgressBarPercent.AutoSize  := False;
  LabelProgressBarPercent.Alignment := taRightJustify;
  //Extract Filename
  LabelExtractFileName            := TLabel.Create(WizardForm);
  LabelExtractFileName.Parent     := WizardForm.InstallingPage;
  LabelExtractFileName.Left       := ISDoneProgressBarMain.Left;
  LabelExtractFileName.Top        := ISDoneProgressBarMain.Top - ScaleY(18);
  LabelExtractFileName.Width      := ISDoneProgressBarMain.Width - ScaleX(50);
  LabelExtractFileName.Height     := ScaleY(18);
  LabelExtractFileName.AutoSize   := False;
  LabelExtractFileName.Alignment  := taLeftJustify;
  //Elapsed Time
  LabelElapsedTime            := TLabel.Create(WizardForm);
  LabelElapsedTime.Parent     := WizardForm.InstallingPage;
  LabelElapsedTime.Left       := ISDoneProgressBarMain.Left;
  LabelElapsedTime.Top        := ISDoneProgressBarMain.Top + ISDoneProgressBarMain.Height + ScaleY(5);
  LabelElapsedTime.Width      := ISDoneProgressBarMain.Width div 2;
  LabelElapsedTime.AutoSize   := False;
  LabelElapsedTime.Alignment  := taLeftJustify;
  //Remaining Time
  LabelRemainingTime            := TLabel.Create(WizardForm);
  LabelRemainingTime.Parent     := WizardForm.InstallingPage;
  LabelRemainingTime.Left       := ISDoneProgressBarMain.Left + LabelElapsedTime.Width;
  LabelRemainingTime.Top        := ISDoneProgressBarMain.Top + ISDoneProgressBarMain.Height + ScaleY(5);
  LabelRemainingTime.Width      := ISDoneProgressBarMain.Width div 2;
  LabelRemainingTime.Height     := ScaleY(18);
  LabelRemainingTime.AutoSize   := False;
  LabelRemainingTime.Alignment  := taRightJustify;
  //My Cancel Button
  MyCancelButton            := TButton.Create(WizardForm);
  MyCancelButton.Parent     := WizardForm;
  MyCancelButton.Left       := WizardForm.CancelButton.Left;
  MyCancelButton.Top        := WizardForm.CancelButton.Top;
  MyCancelButton.Width      := WizardForm.CancelButton.Width;
  MyCancelButton.Height     := WizardForm.CancelButton.Height;
  MyCancelButton.OnClick    := @CancelButtonOnClick;
  MyCancelButton.Caption    := 'Cancel'
 
  
  //Welcome Title Name
  LabelWelcomeTitleName             := TLabel.Create(WizardForm);
  LabelWelcomeTitleName.Parent      := WizardForm.WelcomePage;  
  LabelWelcomeTitleName.Left        := 200;
  LabelWelcomeTitleName.Top         := 10;
  LabelWelcomeTitleName.Caption     := '{#PatchName}';
  LabelWelcomeTitleName.Autosize    := True;
  LabelWelcomeTitleName.Font.Name   := 'Segoe UI';
  LabelWelcomeTitleName.Font.Size   := 24;
  LabelWelcomeTitleName.Font.Style  := [fsBold];
  LabelWelcomeTitleName.Font.Color  :=  $008CFF;
  
  //Welcome Title Season
  LabelWelcomeTitleSeason            := TLabel.Create(WizardForm);
  LabelWelcomeTitleSeason.Parent     := WizardForm.WelcomePage;  
  LabelWelcomeTitleSeason.Left       := 200;
  LabelWelcomeTitleSeason.Top        := 50;
  LabelWelcomeTitleSeason.Caption    := 'Season {#PatchSeason}';
  LabelWelcomeTitleSeason.Autosize   := True;
  LabelWelcomeTitleSeason.Font.Name  := 'Segoe UI';
  LabelWelcomeTitleSeason.Font.Size  := 16;
  LabelWelcomeTitleSeason.Font.Style := [fsBold];
  LabelWelcomeTitleSeason.Font.Color := $C0C0C0;
  
  //Finished Title
  LabelFinishedTitle            := TLabel.Create(WizardForm);
  LabelFinishedTitle.Parent     := WizardForm.FinishedPage;  
  LabelFinishedTitle.Left       := LabelWelcomeTitleName.Left;
  LabelFinishedTitle.Top        := LabelWelcomeTitleName.Top;  
  LabelFinishedTitle.Caption    := 'COMPLETED';
  LabelFinishedTitle.AutoSize   := True;
  LabelFinishedTitle.Font.Name  := 'Segoe UI';
  LabelFinishedTitle.Font.Size  := 24;
  LabelFinishedTitle.Font.Style := [fsBold]
  LabelFinishedTitle.Font.Color := $008CFF;
  
  //Finished Sub Title
  LabelFinishedSubTitle             := TLabel.Create(WizardForm);
  LabelFinishedSubTitle.Parent      := WizardForm.FinishedPage;
  LabelFinishedSubTitle.Left        := LabelWelcomeTitleSeason.Left;
  LabelFinishedSubTitle.Top         := LabelWelcomeTitleSeason.Top;
  LabelFinishedSubTitle.Caption     := ExpandConstant('{cm:PatchName} {cm:PatchYear}');
  LabelFinishedSubTitle.AutoSize    := True;
  LabelFinishedSubTitle.Font.Name   := 'Segoe UI';
  LabelFinishedSubTitle.Font.Size   := 16;
  LabelFinishedSubTitle.Font.Style  := [fsBold];
  LabelFinishedSubTitle.Font.Color  := $C0C0C0;
  
  //Finished Text
  LabelFinishedText             := TLabel.Create(WizardForm);
  LabelFinishedText.Parent      := WizardForm.FinishedPage;
  LabelFinishedText.Top         := 120;
  LabelFinishedText.Left        := 200;  
  LabelFinishedText.Caption     := ExpandConstant('{cm:FinishedText}');
  LabelFinishedText.Autosize    := True;
  LabelFinishedText.Font.Name   := 'Segoe UI';
  LabelFinishedText.Font.Size   := 10;
  //LabelFinishedText.Font.Style  := [fsBold];
  //LabelFinishedText.Font.Color  := $000000;

  //Finished Sub Text
  LabelFinishedSubText            := TLabel.Create(WizardForm);
  LabelFinishedSubText.Parent     := WizardForm.FinishedPage;
  LabelFinishedSubText.Top        := 240;
  LabelFinishedSubText.Left       := 200;
  LabelFinishedSubText.Caption    := ExpandConstant('{cm:FinishedSubText}');
  LabelFinishedSubText.Autosize   := True;
  LabelFinishedSubText.Font.Name  := 'Segoe UI';
  LabelFinishedSubText.Font.Size  := 10;
  //LabelFinishedSubText.Font.Style := [fsBold];
  //LabelFinishedSubText.Font.Color := $000000;

  //Bitmap Image EvoWeb
  BitmapImageWebsite           := TBitmapImage.Create(WizardForm);
  BitmapImageWebsite.Parent    := WizardForm.InstallingPage;
  BitmapImageWebsite.Top       := WizardForm.ProgressGauge.Top + 80;
  BitmapImageWebsite.Left      := WizardForm.ProgressGauge.Left;
  BitmapImageWebsite.Cursor    := crHand;
  BitmapImageWebsite.OnClick   := @Website
  BitmapImageWebsite.Autosize  := True;
  BitmapImageWebsite.Bitmap.LoadFromFile(ExpandConstant('{tmp}\logo.bmp'));

end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if (CurPageID = wpFinished) and ISDoneError then begin
    LabelFinishedTitle.Caption  := 'NOT COMPLETED';
    LabelFinishedText.Caption   := ExpandConstant('{cm:FinishedErrorText}');
  end;
end;

function CheckError:boolean;
begin
  result:= not ISDoneError;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then begin 
    //Settings Archive Percent
    intSoundPack          := 20;
    intKitserverPack      := 10;
    intBallsPack          := 5;
    intBootsPack          := 5;
    intFacesPack          := 5;
    intHairPack           := 5;
    intStadiumsPack       := 40;
    intUniPack            := 10;
    
    //balls.pack
    if not WizardForm.ComponentsList.Checked[4] then begin
      intSoundPack := intSoundPack + intBallsPack;
    end;
    //boots.pack
    if not WizardForm.ComponentsList.Checked[6] then begin
      intSoundPack := intSoundPack + intBootsPack
    end;

    //faces.pack
    if not WizardForm.ComponentsList.Checked[7] then begin
      intSoundPack := intSoundPack + intFacesPack
    end;
    //hair.pack
    if not WizardForm.ComponentsList.Checked[8] then begin
      intSoundPack := intSoundPack + intHairPack
    end;
    //stadiums.pack
    if not WizardForm.ComponentsList.Checked[9] then begin
      intSoundPack := intSoundPack + intStadiumsPack
    end;
    //uni.pack
    if not WizardForm.ComponentsList.Checked[10] then begin
      intSoundPack := intSoundPack + intUniPack
    end;

  
         
    ISDoneCancel  := 0;
    ISDoneError   := True;
    
    WizardForm.CancelButton.Hide;
    MyCancelButton.Show;

    WizardForm.StatusLabel.Caption:=ExpandConstant('{cm:Extracted}');    
    WizardForm.StatusLabel.Height := ScaleY(18);
  
    ExtractTemporaryFile('unarc.dll');
    ExtractTemporaryFile('CLS-precomp.dll');
    ExtractTemporaryFile('CLS-srep.dll');
    ExtractTemporaryFile('precomp.exe');
    ExtractTemporaryFile('srep.exe');
    ExtractTemporaryFile('english.ini');
    
    if ISDoneInit(ExpandConstant('{tmp}\records.inf'), $F777, 0,0,0, MainForm.Handle, 512, @ProgressCallback) then begin
      repeat
        ChangeLanguage('english');
        if not SrepInit('',512,0) then break;
        if not PrecompInit('',128,0) then break;
        if not FileSearchInit(true) then break;

        //sound.pack
        if not ShowChangeDiskWindow ('Please Insert Disk To Continue...', ExpandConstant('{src}'),'sound.pack') then break;
        if not ISArcExtract( 0, intSoundPack, ExpandConstant('{src}\sound.pack'), ExpandConstant('{app}'), '', false, '5548219773546854', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), False) then break;        

        //kitserver.pack
        if not ShowChangeDiskWindow ('Please Insert Disk To Continue...', ExpandConstant('{src}'),'kitserver.pack') then break;
        if not ISArcExtract( 0, intKitserverPack, ExpandConstant('{src}\kitserver.pack'), ExpandConstant('{app}'), '', false, '5548219773546854', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), False) then break;        

        //balls.pack
        if WizardForm.ComponentsList.Checked[4] then begin
          if not ShowChangeDiskWindow ('Please Insert Disk To Continue...', ExpandConstant('{src}'),'balls.pack') then break;
          if not ISArcExtract( 0, intBallsPack, ExpandConstant('{src}\balls.pack'), ExpandConstant('{app}'), '', false, '5548219773546854', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), False) then break;        
        end;

        //boots.pack
        if WizardForm.ComponentsList.Checked[6] then begin
          if not ShowChangeDiskWindow ('Please Insert Disk To Continue...', ExpandConstant('{src}'),'boots.pack') then break;
          if not ISArcExtract( 0, intBootsPack, ExpandConstant('{src}\boots.pack'), ExpandConstant('{app}'), '', false, '5548219773546854', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), False) then break;        
        end;

        //faces.pack
        if WizardForm.ComponentsList.Checked[7] then begin
          if not ShowChangeDiskWindow ('Please Insert Disk To Continue...', ExpandConstant('{src}'),'faces.pack') then break;
          if not ISArcExtract( 0, intFacesPack, ExpandConstant('{src}\faces.pack'), ExpandConstant('{app}'), '', false, '5548219773546854', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), False) then break;        
        end;

        //hair.pack
        if WizardForm.ComponentsList.Checked[8] then begin
          if not ShowChangeDiskWindow ('Please Insert Disk To Continue...', ExpandConstant('{src}'),'hair.pack') then break;
          if not ISArcExtract( 0, intHairPack, ExpandConstant('{src}\hair.pack'), ExpandConstant('{app}'), '', false, '5548219773546854', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), False) then break;        
        end;

        //stadiums.pack
        if WizardForm.ComponentsList.Checked[9] then begin
          if not ShowChangeDiskWindow ('Please Insert Disk To Continue...', ExpandConstant('{src}'),'stadiums.pack') then break;
          if not ISArcExtract( 0, intStadiumsPack, ExpandConstant('{src}\stadiums.pack'), ExpandConstant('{app}'), '', false, '5548219773546854', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), False) then break;        
        end;

        //uni.pack
        if WizardForm.ComponentsList.Checked[10] then begin
          if not ShowChangeDiskWindow ('Please Insert Disk To Continue...', ExpandConstant('{src}'),'uni.pack') then break;
          if not ISArcExtract( 0, intUniPack, ExpandConstant('{src}\uni.pack'), ExpandConstant('{app}'), '', false, '5548219773546854', ExpandConstant('{tmp}\arc.ini'), ExpandConstant('{app}'), False) then break;        
        end;
        
        ISDoneError := False;
      until true;
      EnableWindow(WizardForm.Handle, True);
      ISDoneStop;
    end;    
    HideControls;
    WizardForm.CancelButton.Visible := True;
    WizardForm.CancelButton.Enabled := False;
  end;
  
  //Post Install
  if (CurStep=ssPostInstall) and ISDoneError then begin
    Exec2(ExpandConstant('{uninstallexe}'), '/VERYSILENT', False);
  end;
end;


procedure InitializeWizard();
begin
  LabelInfoName             := TLabel.Create(WizardForm);
  LabelInfoName.Parent      := WizardForm.WelcomePage;
  LabelInfoName.Caption     := 'Name:'
  LabelInfoName.Top         := 120;
  LabelInfoName.Left        := 200;
  LabelInfoName.Autosize    := True;
  LabelInfoName.Font.Name   := 'Segoe UI';
  LabelInfoName.Font.Size   := 10;
  LabelInfoName.Font.Style  := [fsBold];
  LabelInfoName.Font.Color  := $000000;

  LabelInfoType             := TLabel.Create(WizardForm);
  LabelInfoType.Parent      := WizardForm.WelcomePage;
  LabelInfoType.Caption     := 'Type:'
  LabelInfoType.Top         := 140;
  LabelInfoType.Left        := 200;
  LabelInfoType.Autosize    := True;
  LabelInfoType.Font.Name   := 'Segoe UI';
  LabelInfoType.Font.Size   := 10;
  LabelInfoType.Font.Style  := [fsBold];
  LabelInfoType.Font.Color  := $000000;

  LabelInfoSeason             := TLabel.Create(WizardForm);
  LabelInfoSeason.Parent      := WizardForm.WelcomePage;
  LabelInfoSeason.Caption     := 'Season:'
  LabelInfoSeason.Top         := 160;
  LabelInfoSeason.Left        := 200;
  LabelInfoSeason.Autosize    := True;
  LabelInfoSeason.Font.Name   := 'Segoe UI';
  LabelInfoSeason.Font.Size   := 10;
  LabelInfoSeason.Font.Style  := [fsBold];
  LabelInfoSeason.Font.Color  := $000000;

  LabelInfoLanguage             := TLabel.Create(WizardForm);
  LabelInfoLanguage.Parent      := WizardForm.WelcomePage;
  LabelInfoLanguage.Caption     := 'Language:'
  LabelInfoLanguage.Top         := 180;
  LabelInfoLanguage.Left        := 200;
  LabelInfoLanguage.Autosize    := True;
  LabelInfoLanguage.Font.Name   := 'Segoe UI';
  LabelInfoLanguage.Font.Size   := 10;
  LabelInfoLanguage.Font.Style  := [fsBold];
  LabelInfoLanguage.Font.Color  := $000000;

  LabelInfoDeveloper             := TLabel.Create(WizardForm);
  LabelInfoDeveloper.Parent      := WizardForm.WelcomePage;
  LabelInfoDeveloper.Caption     := 'Developer:'
  LabelInfoDeveloper.Top         := 200;
  LabelInfoDeveloper.Left        := 200;
  LabelInfoDeveloper.Autosize    := True;
  LabelInfoDeveloper.Font.Name   := 'Segoe UI';
  LabelInfoDeveloper.Font.Size   := 10;
  LabelInfoDeveloper.Font.Style  := [fsBold];
  LabelInfoDeveloper.Font.Color  := $000000;

  LabelInfoDescription             := TLabel.Create(WizardForm);
  LabelInfoDescription.Parent      := WizardForm.WelcomePage;
  LabelInfoDescription.Caption     := 'Description:'
  LabelInfoDescription.Top         := 220;
  LabelInfoDescription.Left        := 200;
  LabelInfoDescription.Autosize    := True;
  LabelInfoDescription.Font.Name   := 'Segoe UI';
  LabelInfoDescription.Font.Size   := 10;
  LabelInfoDescription.Font.Style  := [fsBold];
  LabelInfoDescription.Font.Color  := $000000;

  LabelInfoNameSub             := TLabel.Create(WizardForm);
  LabelInfoNameSub.Parent      := WizardForm.WelcomePage;
  LabelInfoNameSub.Caption     := ExpandConstant('{cm:PatchName}');
  LabelInfoNameSub.Top         := 120;
  LabelInfoNameSub.Left        := 300;
  LabelInfoNameSub.Autosize    := True;
  LabelInfoNameSub.Font.Name   := 'Segoe UI';
  LabelInfoNameSub.Font.Size   := 10;
  //LabelInfoNameSub.Font.Style  := [fsBold];
  //LabelInfoNameSub.Font.Color  := $C0C0C0;

  LabelInfoTypeSub             := TLabel.Create(WizardForm);
  LabelInfoTypeSub.Parent      := WizardForm.WelcomePage;
  LabelInfoTypeSub.Caption     := ExpandConstant('{cm:PatchType}');
  LabelInfoTypeSub.Top         := 140;
  LabelInfoTypeSub.Left        := 300;
  LabelInfoTypeSub.Autosize    := True;
  LabelInfoTypeSub.Font.Name   := 'Segoe UI';
  LabelInfoTypeSub.Font.Size   := 10;
  //LabelInfoTypeSub.Font.Style  := [fsBold];
  //LabelInfoTypeSub.Font.Color  := $C0C0C0;

  LabelInfoSeasonSub             := TLabel.Create(WizardForm);
  LabelInfoSeasonSub.Parent      := WizardForm.WelcomePage;
  LabelInfoSeasonSub.Caption     := ExpandConstant('{cm:PatchSeason}');
  LabelInfoSeasonSub.Top         := 160;
  LabelInfoSeasonSub.Left        := 300;
  LabelInfoSeasonSub.Autosize    := True;
  LabelInfoSeasonSub.Font.Name   := 'Segoe UI';
  LabelInfoSeasonSub.Font.Size   := 10;
  //LabelInfoSeasonSub.Font.Style  := [fsBold];
  //LabelInfoSeasonSub.Font.Color  := $C0C0C0;

  LabelInfoLanguageSub             := TLabel.Create(WizardForm);
  LabelInfoLanguageSub.Parent      := WizardForm.WelcomePage;
  LabelInfoLanguageSub.Caption     := ExpandConstant('{cm:PatchLanguage}');
  LabelInfoLanguageSub.Top         := 180;
  LabelInfoLanguageSub.Left        := 300;
  LabelInfoLanguageSub.Autosize    := True;
  LabelInfoLanguageSub.Font.Name   := 'Segoe UI';
  LabelInfoLanguageSub.Font.Size   := 10;
  //LabelInfoLanguageSub.Font.Style  := [fsBold];
  //LabelInfoLanguageSub.Font.Color  := $C0C0C0;

  LabelInfoDeveloperSub             := TLabel.Create(WizardForm);
  LabelInfoDeveloperSub.Parent      := WizardForm.WelcomePage;
  LabelInfoDeveloperSub.Caption     := ExpandConstant('{cm:PatchDeveloper}');
  LabelInfoDeveloperSub.Top         := 200;
  LabelInfoDeveloperSub.Left        := 300;
  LabelInfoDeveloperSub.Autosize    := True;
  LabelInfoDeveloperSub.Font.Name   := 'Segoe UI';
  LabelInfoDeveloperSub.Font.Size   := 10;
  //LabelInfoDeveloperSub.Font.Style  := [fsBold];
  //LabelInfoDeveloperSub.Font.Color  := $C0C0C0;

  LabelInfoDescriptionSub             := TLabel.Create(WizardForm);
  LabelInfoDescriptionSub.Parent      := WizardForm.WelcomePage;
  LabelInfoDescriptionSub.Caption     := ExpandConstant('{cm:PatchDescription}');
  LabelInfoDescriptionSub.Top         := 220;
  LabelInfoDescriptionSub.Left        := 300;
  LabelInfoDescriptionSub.Autosize    := True;
  LabelInfoDescriptionSub.Font.Name   := 'Segoe UI';
  LabelInfoDescriptionSub.Font.Size   := 10;
  //LabelInfoDescriptionSub.Font.Style  := [fsBold];
  //LabelInfoDescriptionSub.Font.Color  := $C0C0C0;

  
  WizardForm.WizardBitmapImage.Width:=180;
  WizardForm.WizardBitmapImage2.Width := 180;

  WizardForm.WizardSmallBitmapImage.Left:=250;
  WizardForm.WizardSmallBitmapImage.Top:=0;
  WizardForm.WizardSmallBitmapImage.Width:=250;
  WizardForm.WizardSmallBitmapImage.Height:=58;

  WizardForm.WelcomeLabel1.Hide;
  WizardForm.WelcomeLabel2.Hide;
  
  WizardForm.FinishedLabel.Hide;
  WizardForm.FinishedHeadingLabel.Hide;

  WizardForm.PageNameLabel.Width:=180;
  WizardForm.PageDescriptionLabel.Width:=200;

  WizardForm.ProgressGauge.Hide;
  CreateControls;
  MyCancelButton.Hide;
end;


function InitializeSetup(): Boolean; 
begin
  ExtractTemporaryFile('logo.bmp');
  ExtractTemporaryFile('isskin.dll');
	ExtractTemporaryFile('skin.cjstyles');
  LoadSkin(ExpandConstant('{tmp}\skin.cjstyles'), '');
  Result := True;
  //sound.pack
  //if not FileExists('sound.pack') then 
  //begin
  //  MsgBox('Setup is not complete, missing sound.pack arhive!' #13#10 'The installation can not be resumed.', mbError, MB_OK);
  //  Result := False;
  //  exit;
  //end;
  //kitserver.pack
  //if not FileExists('kitserver.pack') then
  //begin
  //  MsgBox('Setup is not complete, missing kitserver.pack archive!' #13#10 'The installation can not be resumed.', mbError, MB_OK);
  //  Result := False;
  //  Exit;
  //end;
end;

procedure DeinitializeSetup(); 
begin
  UnloadSkin();
end;
