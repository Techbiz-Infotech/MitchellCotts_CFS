pageextension 55005 PurchCreditMemoLines extends "Purch. Cr. Memo Subform"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
            begin
                UpdateDimensionFields();

            end;
        }
        addafter("Shortcut Dimension 1 Code")

        {
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                CaptionClass = '1,2,4';
                Caption = 'Shortcut Dimension 2 Code';
                ToolTip = 'Specifies the code for Shortcut Dimension 4, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            }
        }
    }
    procedure UpdateDimensionFields()
    var
        ManifestLine: Record "Manifest Line";
        ImsSetup: Record "IMS Setup";
    begin
        ImsSetup.Get();
        ManifestLine.Reset();
        ManifestLine.SetRange("shortcut Dimension 4 Code", Rec."Shortcut Dimension 4 Code");
        if ManifestLine.FindFirst() then begin
            if ImsSetup."KPA Receive Manditory" then
                if not ManifestLine.Received then
                    Error('This container %1 is not received', ManifestLine."shortcut Dimension 4 Code");
            Rec."Shortcut Dimension 2 Code" := ManifestLine."Global Dimension 2 Code";
            Rec."Shortcut Dimension 1 Code" := ManifestLine."Global Dimension 1 Code";
            ShortcutDimCode[3] := ManifestLine."Shortcut Dimension 3 Code";
            ShortcutDimCode[4] := ManifestLine."Shortcut Dimension 4 Code";
            ShortcutDimCode[5] := ManifestLine."Shortcut Dimension 5 Code";
            ShortcutDimCode[6] := ManifestLine."Shortcut Dimension 6 Code";
            rec.ValidateShortcutDimCode(2, rec."Shortcut Dimension 2 Code");
            rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
            Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
            Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
            Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);


        end else
            Error('Container %1 could not found', Rec."Shortcut Dimension 4 Code");
    end;
}
