page 55013 "Kephis "
{
    ApplicationArea = All;
    Caption = 'Kephis Memo ';
    PageType = Worksheet;
    SourceTable = Verification;
    UsageCategory = Lists;
    DelayedInsert = true;
    //SourceTableView = where("Shortcut Dimension 6 Code" = filter('EMPTY'));
    layout
    {
        area(content)
        {
            group(General)
            {
                field(ContainerNo; ContainerNo)
                {
                    Caption = 'Container ID';
                    ApplicationArea = all;
                    TableRelation = "Manifest Line";
                    Lookup = true;
                    trigger OnLookup(var text: text): Boolean
                    var
                        ManiLine: Record "Manifest Line";
                    begin

                        ManiLine.Reset();
                        ManiLine.SetRange("Container lock", false);
                        ManiLine.SetRange(Received, True);
                        ManiLine.SetRange(Manifested, true);
                        ManiLine.SetRange(Verified, false);
                        ManiLine.SetRange(Released, False);
                        ManiLine.SetRange("Shortcut Dimension 6 Code", 'EMPTY');
                        if page.RunModal(50140, ManiLine) = Action::LookupOK then begin
                            ContainerNo := ManiLine."Shortcut Dimension 4 Code";
                            GetManifestLineInfo();
                            CurrPage.Update(false);
                        end;
                    end;
                }
            }
            repeater(General1)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                // field(Verified; rec.Verified)
                // {
                //     ApplicationArea = all;
                //     trigger OnValidate()
                //     var
                //         myInt: Integer;
                //     begin
                //         rec."Verification Date" := WorkDate;
                //         rec."Verification Time" := Time;
                //     end;
                // }

                field("Date"; Rec."Date")
                {
                    ToolTip = '';
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Time"; Rec."Time")
                {
                    ToolTip = 'Specifies the value of the  Time field.';
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Container No./Chassis No."; rec."Container No./Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Container Type"; Rec."Container Type")
                {
                    ToolTip = 'Specifies the value of the Container Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the  field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Container  field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Container  field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Shipper Seal"; Rec."Shipper Seal")
                {
                    ToolTip = 'Specifies the value of the Shipper Seal field.';
                    ApplicationArea = All;
                }
                field("Job File No."; rec."Job File No.")
                {
                    ApplicationArea = all;
                }
                field("Manifest Line No."; rec."Manifest Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("New Seal"; rec."New Seal")
                {
                    ApplicationArea = all;
                }
                field("Certificate No"; Rec."Certificate No")
                {
                    ApplicationArea = all;

                }
                field("User ID"; rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            // action("Additional Charges")
            // {
            //     Caption = 'Additional Charges';
            //     ApplicationArea = All;
            //     RunObject = page "AdditionalCharges Verification";
            //     RunPageLink = "Container ID" = field("Global Dimension 1 Code");
            // }
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                trigger OnAction()

                begin
                    Rec."Kephis Posted" := True;
                    IF Confirm('Do you want to Post the Kephis Charge?', true) then begin
                        InsertLog();
                        PostAdditionalCharge(Rec);
                        Commit();
                        rec.DeleteAll();
                    end else
                        exit;
                end;

            }
        }
    }
    var
        BLNo: Code[20];
        ManiLines: Record "Manifest Line";
        VerLogRec2: Record VerificationLog;
        VerificationReport: Report "Custom Verification Order NICT";
        ContainerNo: code[50];


    procedure GetManifestLineInfo()
    var
        ManifestLineRec: Record "Manifest Line";
        VerRec: Record Verification;
        LineNo: Integer;
        RecLogRec: Record ReceivingLog;
    begin
        ManifestLineRec.Reset();
        ManifestLineRec.SetRange(ManifestLineRec."Shortcut Dimension 4 Code", ContainerNo);
        ManifestLineRec.setrange(ManifestLineRec.Manifested, true);
        ManifestLineRec.SetRange(ManifestLineRec.Received, true);
        ManifestLineRec.SetRange(ManifestLineRec."Shortcut Dimension 6 Code", 'EMPTY');
        ManifestLineRec.SetRange(ManifestLineRec.Verified, false);
        if ManifestLineRec.FindFirst() then begin
            LineNo := 10000;
            repeat
                rec.Init();
                rec."Line No." := LineNo;
                rec.Insert();

                rec."Container No./Chassis No." := ManifestLineRec."Container/Chassis No.";
                rec."Container Type" := ManifestLineRec."Container Type";
                rec."Shortcut Dimension 5 Code" := ManifestLineRec."Shortcut Dimension 5 Code";
                rec."Shortcut Dimension 3 Code" := ManifestLineRec."Shortcut Dimension 3 Code";
                rec."Shortcut Dimension 4 Code" := ManifestLineRec."Shortcut Dimension 4 Code";
                rec."Shortcut Dimension 6 Code" := ManifestLineRec."Shortcut Dimension 6 Code";
                rec.Description := ManifestLineRec.Description;
                rec."Job File No." := ManifestLineRec."Job File No.";
                rec."BL No." := ManifestLineRec."BL No.";
                rec."Manifest Line No." := ManifestLineRec."Line No.";
                Rec.Date := WorkDate;
                Rec.Time := DT2Time(CurrentDateTime);
                rec."Global Dimension 1 Code" := ManifestLineRec."Global Dimension 1 Code";
                RecLogRec.Reset();
                RecLogRec.SetRange(RecLogRec."BL No.", ManifestLineRec."BL No.");
                RecLogRec.SetRange(RecLogRec."Container No./Chassis No.", ManifestLineRec."Container/Chassis No.");
                if RecLogRec.FindSet() then
                    Rec."Shipper Seal" := RecLogRec."Shipper Seal No.";
                rec.Modify();
                LineNo += 10000;
            until ManifestLineRec.Next = 0;
        end;
        clear(BLNo);
        CurrPage.Update();
    end;

    procedure InsertLog()
    var
        VerRec: Record Verification;
        VerLogRec: Record VerificationLog;
        VerLogRec2: Record VerificationLog;
        AdditionalCharges: Record AdditionalChargesVerification;
        PostedAdditionalCharges: Record "Posted AddCharges Verification";
        EntryNo: Integer;
        lineno: Integer;
    begin
        VerLogRec2.Reset();
        if VerLogRec2.FindLast() then
            EntryNo := VerLogRec2."Entry No." + 1
        else
            EntryNo := 1;
        VerRec := Rec;
        VerRec.Reset();
        IF VerRec.FindSet() then begin
            repeat
                VerLogRec.Init();
                VerLogRec."Entry No." := EntryNo;
                VerLogRec."Line No." := VerRec."Line No.";
                VerLogRec.Date := VerRec.Date;
                VerLogRec.Time := VerRec.Time;
                VerLogRec."Container No./Chassis No." := VerRec."Container No./Chassis No.";
                VerLogRec."Global Dimension 1 Code" := VerRec."Global Dimension 1 Code";
                VerLogRec."Job File No." := VerRec."Job File No.";
                VerLogRec."BL No." := rec."BL No.";
                VerLogRec."Container Type" := VerRec."Container Type";
                VerLogRec."Shortcut Dimension 5 Code" := VerRec."Shortcut Dimension 5 Code";
                VerLogRec."Shortcut Dimension 3 Code" := VerRec."Shortcut Dimension 3 Code";
                VerLogRec."Shortcut Dimension 4 Code" := VerRec."Shortcut Dimension 4 Code";
                VerLogRec."Shortcut Dimension 6 Code" := VerRec."Shortcut Dimension 6 Code";
                verLogRec.Description := VerRec.Description;
                VerLogRec."Certificate No" := Rec."Certificate No";
                VerLogRec."Kephis Posted" := Rec."Kephis Posted";
                VerLogRec."Shipper Seal" := VerRec."Shipper Seal";
                VerLogRec."New Seal" := VerRec."New Seal";
                VerLogRec.Insert();
                EntryNo := EntryNo + 1;

                // AdditionalCharges.Reset();
                // AdditionalCharges.SetRange("Container ID", VerLogRec."Global Dimension 1 Code");
                // IF AdditionalCharges.FindFirst() Then begin
                //     repeat
                //         PostedAdditionalCharges.Init();
                //         PostedAdditionalCharges."Verification Entry No." := VerLogRec."Entry No.";
                //         PostedAdditionalCharges."Verification Type" := AdditionalCharges."Verification Type";
                //         PostedAdditionalCharges."Container ID" := AdditionalCharges."Container ID";
                //         PostedAdditionalCharges."Line No." := AdditionalCharges."Line No.";
                //         //PostedAdditionalCharges."Verification Charges" := AdditionalCharges."Verification Charges";
                //         PostedAdditionalCharges.insert;
                //         AdditionalCharges.Delete();
                //     until AdditionalCharges.next = 0;
                //end;
                if VerRec."Shortcut Dimension 4 Code" = 'COONTAINER' then begin

                    PostedAdditionalCharges.Reset();
                    PostedAdditionalCharges.SetRange("Container ID", VerRec."Shortcut Dimension 4 Code");
                    if PostedAdditionalCharges.FindLast() then
                        lineno := PostedAdditionalCharges."Line No." + 10000
                    else
                        lineno := 10000;
                    PostedAdditionalCharges.Init();
                    PostedAdditionalCharges."Verification Entry No." := VerRec."Line No.";
                    PostedAdditionalCharges."Verification Type" := VerRec."Verification Type";
                    PostedAdditionalCharges."Container ID" := VerRec."Shortcut Dimension 4 Code";
                    PostedAdditionalCharges."Line No." := lineno;
                    PostedAdditionalCharges.insert;
                end;
            UNTIL VerRec.Next = 0;

            Message('Posted Successfully');
        end;
    end;

    local procedure PostAdditionalCharge(LogEntry: Record Verification)
    var
        StandardRate: Record "Standard Rate Charges Setup";
        AdditionalCharge: Record "Additional Charges - Receiving";
        NextLineNo: Integer;
    begin



        StandardRate.SetRange("Kephis Charge", true);
        StandardRate.SetRange("Shortcut Dimension 5 Code", LogEntry."Shortcut Dimension 5 Code");
        if not StandardRate.FindFirst() then
            Error('No standard rate found');


        AdditionalCharge.SetRange("Container ID", LogEntry."Shortcut Dimension 4 Code");
        if AdditionalCharge.FindLast() then
            NextLineNo := AdditionalCharge."Line No." + 10000
        else
            NextLineNo := 10000;

        // 3. Insert the charge line
        AdditionalCharge.Init();
        AdditionalCharge."Container ID" := LogEntry."Shortcut Dimension 4 Code";
        AdditionalCharge."Line No." := NextLineNo;
        AdditionalCharge.Rate := StandardRate.Rate;
        AdditionalCharge."Charges Code" := StandardRate."Charges Code";
        AdditionalCharge.Insert(true);
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        rec.DeleteAll();
    end;
}




















