;-------------------------------------------------------------------------------;
;                                                                               ;
;   Name:         Installer: PES 6 Patch                                        ;
;   Type:         Inno Setup Script | Open Source                               ;
;   Date:         20 January 2016                                               ;
;   Version:      1.1.0.0                                                       ;
;   License:      http://creativecommons.org/licenses/by-nc-sa/4.0/             ;
;   Website:      www.github.com/jasarsoft/p6pinstaller                         ;
;   Contact:      edinjasar14@gmail.com                                         ;
;   Developer:    Edin Jašareviæ                                                ;
;                                                                               ;
;   This code is not designed to violate someone's copyright, and does not      ;
;   allow it to be used for the same. Use of this code in part or completely    ;
;   with the changes as an individual or organization the author disclaims      ;
;   all liability for damages of users.                                         ;
;                                                                               ;
;   Copyright(c) 2005 Pro Evolution Soccer 6 by KONAMI                          ;
;   Copyright(c) 2016 PES 6 Patch Installer by Edin Jašareviæ                   ;
;                                                                               ;
;-------------------------------------------------------------------------------;

;//--- Basic Patch Information ---\\
#define PatchName "Patch Name"
#define PatchType "PES6 Standalone Patch"
#define PatchYear "2015"
#define PatchSeason "2014/2015"
#define PatchAuthor "Patch TM"
#define PatchLanguage "English"
;Value in bayte!!!
#define PatchSize "1024"
#define PatchSizeBalls "1024"
#define PatchSizeBoots "1024"
#define PatchSizeFaces "1024"
#define PatchSizeHair "1024"
#define PatchSizeStadium "1024"
#define PatchSizeUni "1024"

; The following parameters are not required, just put in a comment to the  exclusion.
#define PatchID "7032F904-4314-4BD5-A3F5-351C6BB1C7B7"
#define PatchVersion "1.1.0.0"
;#define PatchLanguage2 "German"
;#define PatchLangauge3 "Italian"
;#define PatchLanguage4 "French"
;#define PatchLangauge5 "Polish"
;#define PatchDirInstall "Patch Name"
;#define PatchDirStartMenu "Patch Name"

#define PatchIcon "icon\patch.ico"
#define PatchImage "image\180x314.bmp"
#define PatchTopImage "image\250x58.bmp"

#define PatchLicense "help\license.txt"
#define PatchReadme "help\readme.rtf"

#define SizeByte "1048576"
#define Version "1.1.0.0"
#define Developer "FIREBIRD TEAM"
#define Language "English"
#define Description "No requirements for PES 6 pre-installed."

[Setup]
AppName={#PatchName}
AppVerName={#PatchName} {#PatchSeason}
AppPublisher={#PatchAuthor}
UninstallFilesDir={app}\uninstall
VersionInfoCopyright={#PatchAuthor}
VersionInfoDescription={#PatchName} {#PatchYear}
OutputDir=output
OutputBaseFilename=installer
SolidCompression=yes
Compression=lzma2/ultra64
InternalCompressLevel=ultra64 
ExtraDiskSpaceRequired={#PatchSize}
AllowNoIcons=yes
#ifdef PatchID
AppId={{{#PatchID}}}
#endif
#ifdef PatchDirInstall
DefaultDirName={sd}\Games\{#PatchDirInstall}
#else
DefaultDirName={sd}\Games\{#PatchName}
#endif
#ifdef PatchDirStartMenu
DefaultGroupName={#PatchDirStartMenu}
#else
DefaultGroupName={#PatchName}
#endif
#ifdef PatchIcon
SetupIconFile={#PatchIcon}
#endif
#ifdef PatchImage
WizardImageFile={#PatchImage}
#endif
#ifdef PatchTopImage
WizardSmallImageFile={#PatchTopImage}
#endif
#ifdef PatchVersion
VersionInfoVersion={#PatchVersion}
#endif
#ifdef PatchLicense
LicenseFile={#PatchLicense}
#endif
#ifdef PatchReadme
InfoBeforeFile={#PatchReadme}
#endif


[Types]
Name: recommend; Description: "Install with Recommend settings";
Name: custom; Description: "Install with Custom settings"; Flags: iscustom