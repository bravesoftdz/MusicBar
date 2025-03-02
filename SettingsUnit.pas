unit SettingsUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, JPEG,
    Vcl.ExtDlgs, Vcl.ExtCtrls;

type
    TSettingsForm = class(TForm)
        LanguagesBox: TComboBox;
        LngLabel: TLabel;
        SaveSettingsButton: TBitBtn;
        AboutButton: TBitBtn;
        SettingsLabel: TLabel;
        Panel1: TPanel;
        procedure SaveSettingsButtonClick(Sender: TObject);
        procedure AboutButtonClick(Sender: TObject);
        procedure LoadSettings();

    private
    { Private declarations }
    public
    { Public declarations }
    end;

const
    SETTINGS_FILE_NAME = 'settings.cfg';
    ENGLISH = 'English';
    RUSSIAN = '�������';

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}

uses
    MainUnit, CreatePlaylistUnit, RenamePlaylistUnit, AboutUnit, LocalizationUnit, ToolsUnit;

procedure TSettingsForm.LoadSettings();
begin
    LanguagesBox.Clear;
    LanguagesBox.Items.Add(RUSSIAN);
    LanguagesBox.Items.Add(ENGLISH);
    if Language = ENG then
        LanguagesBox.Text := ENGLISH
    else
        LanguagesBox.Text := RUSSIAN;
end;

procedure TSettingsForm.SaveSettingsButtonClick(Sender: TObject);
var
    CfgFile: TextFile;
    Cap, Msg: string;
begin
    if Length(LanguagesBox.Text) <> 0 then
    begin
        try
            AssignFile(CfgFile, ExeDirectory + SETTINGS_FILE_NAME);
            Rewrite(CfgFile);
            if LanguagesBox.Text = ENGLISH then
            begin
                Write(CfgFile, ENG_LNG);
                Language := ENG;
                Localization.SetLanguage(ENG);
            end
            else
            begin
                Write(CfgFile, RUS_LNG);
                Language := RUS;
                Localization.SetLanguage(RUS);
            end;
            CloseFile(CfgFile);
            MainForm.UpdateAmountOfTracks;
            Localization.SelectLanguageForMessage(
                Cap, Msg,
                SETTINGS_CAP_RUS, CHNG_SUCC_MSG_RUS,
                SETTINGS_CAP_ENG, CHNG_SUCC_MSG_ENG);
            MessageBox(Handle, PChar(Msg), PChar(Cap), MB_OK + MB_ICONINFORMATION);
        except
            Localization.SelectLanguageForMessage(
                Cap, Msg,
                SETTINGS_CAP_RUS, ERR_MSG_RUS,
                SETTINGS_CAP_ENG, ERR_MSG_ENG);
            MessageBox(Handle, PChar(Msg), PChar(Cap), MB_OK + MB_ICONERROR);
        end;
    end;
end;

procedure TSettingsForm.AboutButtonClick(Sender: TObject);
begin
    AboutForm.ShowModal;
end;


end.
