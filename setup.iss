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
SetupIconFile=icon\{#PatchIcon}
#endif
#ifdef PatchImage
  WizardImageFile=image\{#PatchImage}
#endif
#ifdef PatchTopImage
  WizardSmallImageFile=image\{#PatchTopImage}
#endif
#ifdef PatchVersion
VersionInfoVersion={#PatchVersion}
#endif
;//Patch License
#ifdef PatchLicense
  LicenseFile=help\{#PatchLicense} 
#endif
;//Patch Readme
#ifdef PatchReadme
  InfoBeforeFile=help\{#PatchReadme}
#endif