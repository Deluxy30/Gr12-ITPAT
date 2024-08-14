unit PropertyDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TfrmPropDetails = class(TForm)
    imgAgency: TImage;
    redPropDetails: TRichEdit;
    btnBookShowing: TButton;
    btnStartApplication: TButton;
    lblAgentName: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPropDetails: TfrmPropDetails;

implementation

{$R *.dfm}

end.
