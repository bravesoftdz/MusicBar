unit CreatePlaylistUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.Generics.Defaults, System.Generics.Collections,
    Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.ExtDlgs, Vcl.Menus;

type
    TCreatePlaylistForm = class(TForm)
        NameLabel: TLabel;
        NameEdit: TEdit;
        CreateButton: TBitBtn;
        CancelButton: TBitBtn;
        MusicListBox: TListBox;
        TracksLabel: TLabel;
        AddMusicButton: TBitBtn;
        DeleteButton: TBitBtn;
        AddMusicDialog: TOpenDialog;
        CoverLabel: TLabel;
        PreviewImage: TImage;
        LoadButton: TBitBtn;
        OpenPictureDialog: TOpenPictureDialog;
        PopupMenu1: TPopupMenu;

        procedure AddMusicButtonClick(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure CancelButtonClick(Sender: TObject);
        procedure DeleteButtonClick(Sender: TObject);
        procedure CreateButtonClick(Sender: TObject);
        procedure LoadButtonClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure CreatePlaylist();
    private
    { Private declarations }
    public
    { Public declarations }
    end;

var
    CreatePlaylistForm: TCreatePlaylistForm;

implementation

{$R *.dfm}

uses
    MainUnit, ToolsUnit, LocalizationUnit;

var
    MusicArr: array of string;
    Size: Integer;
    ImagePath: string;

const
    PLAYLISTS_NAME = 'Playlists';
    COVER_NAME = '\cover.jpg';
    FILTER = '������| *.mp3;';

procedure TCreatePlaylistForm.AddMusicButtonClick(Sender: TObject);
var
    Name: string;
begin
    if AddMusicDialog.Execute then
    begin
        Inc(Size);
        SetLength(MusicArr, Size);
        MusicArr[High(MusicArr)] := AddMusicDialog.FileName;
        Name := Tools.CuteName(AddMusicDialog.FileName);
        Delete(Name, Length(Name) - 3, 4);
        MusicListBox.Items.Add(Name);
    end;
end;

procedure TCreatePlaylistForm.CancelButtonClick(Sender: TObject);
begin
    CreatePlaylistForm.Close;
end;

procedure TCreatePlaylistForm.CreateButtonClick(Sender: TObject);
begin
    CreatePlaylist;
end;

procedure TCreatePlaylistForm.CreatePlaylist();
var
    I: Integer;
    NewPlaylistPath, ErrorCap, ErrorMsg: string;
begin
    if Length(NameEdit.Text) <> 0 then
    begin
        if not FileExists(ExeDirectory + PLAYLISTS_NAME) then
            CreateDir(ExeDirectory + PLAYLISTS_NAME);
        NewPlaylistPath := ExeDirectory + PLAYLISTS_NAME + '\' + NameEdit.Text;
        CreateDir(NewPlaylistPath);
        if Length(ImagePath) <> 0 then
        begin
            CopyFile(PChar(ImagePath), PChar(NewPlaylistPath + COVER_NAME), True);
        end;
        for I := 0 to High(MusicArr) do
            CopyFile(PChar(MusicArr[I]), PChar(NewPlaylistPath + '\' + Tools.CuteName(MusicArr[I])), True);
        MainForm.UpdatePlaylists;
        CreatePlaylistForm.Close;
    end
    else
    begin
        Localization.SelectLanguageForMessage
            (ErrorCap, ErrorMsg,
            ERROR_CAP_RUS, ENT_PLST_NAME_RUS,
            ERROR_CAP_ENG, ENT_PLST_NAME_ENG);
        MessageBox(Handle, PChar(ErrorMsg), PChar(ErrorCap), MB_OK + MB_ICONERROR);
    end;
end;

procedure TCreatePlaylistForm.DeleteButtonClick(Sender: TObject);
var
    I: Integer;
    ErrorCap, ErrorMsg: string;
begin
    if MusicListBox.ItemIndex <> -1 then
    begin
        for I := MusicListBox.ItemIndex to High(MusicArr) - 1 do
        begin
            MusicArr[I] := MusicArr[I + 1];
        end;
        Dec(Size);
        SetLength(MusicArr, Size);
        MusicListBox.DeleteSelected;
    end
    else
    begin
        Localization.SelectLanguageForMessage(
            ErrorCap, ErrorMsg,
            ERROR_CAP_RUS, SELECT_TRACK_RUS,
            ERROR_CAP_ENG, SELECT_TRACK_ENG);
        MessageBox(Handle, PChar(ErrorMsg), PChar(ErrorCap), MB_OK + MB_ICONERROR);
    end;
end;

procedure TCreatePlaylistForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Size := 0;
    SetLength(MusicArr, Size);
    NameEdit.Clear;
    MusicListBox.Clear;
    ImagePath := '';
    PreviewImage.Picture := MainForm.DefaultImage.Picture;
end;

procedure TCreatePlaylistForm.FormCreate(Sender: TObject);
begin
    AddMusicDialog.Filter := FILTER;
end;

procedure TCreatePlaylistForm.LoadButtonClick(Sender: TObject);
begin
    if OpenPictureDialog.Execute then
    begin
        ImagePath := OpenPictureDialog.FileName;
        PreviewImage.Picture.LoadFromFile(OpenPictureDialog.FileName);
    end;
end;

end.
