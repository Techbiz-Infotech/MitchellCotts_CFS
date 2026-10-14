pageextension 55026 GenPostSetupExt extends "General Posting Setup"
{
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup."General Posting Setup" then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;

    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup."General Posting Setup" then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;
}
