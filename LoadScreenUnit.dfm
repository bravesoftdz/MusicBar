object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 338
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 110
  TextHeight = 14
  object ProgressBar: TProgressBar
    Left = 0
    Top = 305
    Width = 643
    Height = 33
    Max = 1000
    TabOrder = 0
  end
  object LoadTimer: TTimer
    OnTimer = LoadTimerTimer
    Left = 344
    Top = 136
  end
end
