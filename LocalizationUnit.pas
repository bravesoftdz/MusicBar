unit LocalizationUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.MPlayer, Vcl.StdCtrls, Vcl.ComCtrls,
    Vcl.Menus, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Buttons, Vcl.FileCtrl,
    Vcl.WinXCtrls, mmsystem, ShellAPI, Vcl.Imaging.pngimage, Vcl.JumpList,
    Vcl.WinXPickers, Vcl.TabNotBk, Vcl.ExtDlgs;

type
    TLanguages = (ENG, RUS);
    TLocalization = class(TObject)
        procedure SetLanguage(Language: TLanguages);
        procedure SelectLanguageForMessage(var Cap, Msg: string; RUS_CAP, RUS_MSG, ENG_CAP, ENG_MSG: string);
        procedure SelectLanguageForCaption(var Msg: string; RUS_MSG, ENG_MSG: string);
    end;

const
    RUS_LNG = 'RUS';
    ENG_LNG = 'ENG';

    DAMAGED_FILE_RUS = '���� ��������. �������� ������ ����!';
    DAMAGED_FILE_ENG = 'The file is damaged. Please select another file!';

    ERROR_CAP_RUS = '������';
    ERROR_CAP_ENG = 'Error';

    TRACK_NOT_FOUND_RUS = '���� �� ������ � ���������';
    TRACK_NOT_FOUND_ENG = 'Track not found in playlist';

    SELECT_TRACK_ENG = 'Select track';
    SELECT_TRACK_RUS = '�������� ����';

    DEL_TRACK_QUEST_RUS = '�� ������������� ������ ������� ����: ';
    DEL_TRACK_QUEST_ENG = 'Do you really want to delete the track: ';

    DEL_TRACK_CAP_RUS = '������� ����';
    DEL_TRACK_CAP_ENG = 'Delete track';

    DEL_PLAYLIST_CAP_RUS = '������� ��������';
    DEL_PLAYLIST_CAP_ENG = 'Delete playlist';

    DEL_PLAYLIST_QUEST_RUS = '�� ������������� ������ ������� ��������: ';
    DEL_PLAYLIST_QUEST_ENG = 'Are you sure you want to delete the playlist: ';

    PLST_NOT_FOUND_RUS = '�������� �� ������';
    PLST_NOT_FOUND_ENG = 'Playlist not found';

    SELECT_FOLDER_TITLE_ENG = 'Select a playlist (folder)';
    SELECT_FOLDER_TITLE_RUS = '�������� �������� (�����)';

    SELECT_PLAYLIST_ENG = 'Select a playlist';
    SELECT_PLAYLIST_RUS = '�������� ��������';

    TRACKS_LBL_ENG = 'TRACKS: ';
    TRACKS_LBL_RUS = '������: ';

    CHNG_SUCC_MSG_RUS = '��������� ������� ���������';
    CHNG_SUCC_MSG_ENG = 'Changes saved successfully';

    SETTINGS_CAP_RUS = '���������';
    SETTINGS_CAP_ENG = 'Settings';

    ERR_MSG_RUS = '������ ������� � ����� ������������, ��������� ��������� �� �����';
    ERR_MSG_ENG = 'Configuration file access error, changes will not be saved';

    ENT_PLST_NAME_RUS = '������� �������� ���������';
    ENT_PLST_NAME_ENG = 'Enter playlist title';



var
  Localization: TLocalization;
  Language: TLanguages;

implementation

uses
    MainUnit, CreatePlaylistUnit, RenamePlaylistUnit, AboutUnit, SettingsUnit;

procedure TLocalization.SetLanguage(Language: TLanguages);
begin
    if Language = ENG then
    begin
        with SettingsForm do
        begin
            Caption := 'Settings';
            SettingsLabel.Caption := 'SETTINGS';
            LngLabel.Caption := 'Language';
            AboutButton.Caption := 'About program';
            SaveSettingsButton.Caption := 'Save settings';
        end;

        with MainForm do
        begin
            PlaylistLabel.Caption := 'PLAYLISTS';
            NowPlayLabel.Caption := 'Now play:';

            RepeatButton.Hint := 'Loop track';
            MuteButton.Hint := 'Mute sound';
            ShowPlaylistsButton.Hint := 'Show playlists';
            SettingsButton.Hint := 'Settings';

            CreatePlaylistButton.Hint := 'Create playlist';
            AddPlaylistButton.Hint := 'Add playlist';
            DeletePlaylistButton.Hint := 'Delete playlist';
            UpdatePlaylistsButton.Hint := 'Update playlists';
            ShowPlstsInExpButton.Hint := 'Open playlists in explorer';

            BackButton.Hint := 'Back';
            AddMusicButton.Hint := 'Add track';
            DeleteMusicButton.Hint := 'Delete track';
            UpdateTracksButton.Hint := 'Update tracks';
            ShowCurrPlstInExpButton.Hint := 'Open playlist in explorer';

            RenamePlaylistButton.Hint := 'Rename';
            ChangeCoverButton.Hint := 'Change cover';

            AddMusicDialog.Title := 'Add track';
            AddPlaylistDialog.Title := 'Add playlist';
            OpenPictureDialog.Title := 'Change cover';
        end;

        with CreatePlaylistForm do
        begin
            OpenPictureDialog.Title := 'Select cover';
            AddMusicDialog.Title :=  'Add track';
            Caption := 'Create playlist';
            NameLabel.Caption := 'Name';
            CoverLabel.Caption := 'Cover';
            TracksLabel.Caption := 'Tracks';
            AddMusicButton.Hint := 'Add track';
            DeleteButton.Hint := 'Delete track';
            LoadButton.Caption := 'Load';
            CreateButton.Caption := 'Create';
            CancelButton.Caption := 'Cancel';
        end;

        with RenamePlaylistForm do
        begin
            Caption := 'Rename';
            NameLabel.Caption := 'Enter the name';
            SaveButton.Caption := 'Save';
            CancelButton.Caption := 'Cancel';
        end;

    end
    else
    begin
        with SettingsForm do
        begin
            Caption := '���������';
            SettingsLabel.Caption := '���������';
            LngLabel.Caption := '����';
            AboutButton.Caption := '� ���������';
            SaveSettingsButton.Caption := '��������� ���������';
        end;

        with MainForm do
        begin
            PlaylistLabel.Caption := '���������';
            NowPlayLabel.Caption := '������ ������:';

            RepeatButton.Hint := '��������� ����';
            MuteButton.Hint := '��� �����';
            ShowPlaylistsButton.Hint := '�������� ���������';
            SettingsButton.Hint := '���������';

            CreatePlaylistButton.Hint := '������� ��������';
            AddPlaylistButton.Hint := '�������� ��������';
            DeletePlaylistButton.Hint := '������� ��������';
            UpdatePlaylistsButton.Hint := '�������� ���������';
            ShowPlstsInExpButton.Hint := '������� ��������� � ����������';

            BackButton.Hint := '�����';
            AddMusicButton.Hint := '�������� ����';
            DeleteMusicButton.Hint := '������� ����';
            UpdateTracksButton.Hint := '�������� �����';
            ShowCurrPlstInExpButton.Hint := '������� �������� � ����������';

            RenamePlaylistButton.Hint := '�������������';
            ChangeCoverButton.Hint := '������� �������';

            AddMusicDialog.Title := '�������� ����';
            AddPlaylistDialog.Title := '�������� ��������';
            OpenPictureDialog.Title := '������� �������';
        end;

        with CreatePlaylistForm do
        begin
            OpenPictureDialog.Title := '������� �������';
            AddMusicDialog.Title :=  '�������� ����';
            Caption := '������� ��������';
            NameLabel.Caption := '�������� ���������';
            CoverLabel.Caption := '�������';
            TracksLabel.Caption := '�����';
            AddMusicButton.Hint := '�������� ����';
            DeleteButton.Hint := '������� ����';
            LoadButton.Caption := '���������';
            CreateButton.Caption := '�������';
            CancelButton.Caption := '������';
        end;

        with RenamePlaylistForm do
        begin
            Caption := '�������������';
            NameLabel.Caption := '������� ��������';
            SaveButton.Caption := '���������';
            CancelButton.Caption := '������';
        end;
    end;
end;

procedure TLocalization.SelectLanguageForMessage(var Cap, Msg: string; RUS_CAP, RUS_MSG, ENG_CAP, ENG_MSG: string);
begin
    if Language = ENG then
    begin
        Cap := ENG_CAP;
        Msg := ENG_MSG;
    end
    else
    begin
        Cap := RUS_CAP;
        Msg := RUS_MSG;
    end;
end;

procedure TLocalization.SelectLanguageForCaption(var Msg: string; RUS_MSG, ENG_MSG: string);
begin
    if Language = ENG then
    begin
        Msg := ENG_MSG;
    end
    else
    begin
        Msg := RUS_MSG;
    end;
end;



end.
