page 55073 StrippingJournal
{
    ApplicationArea = All;
    Caption = 'Strippings';
    PageType = Worksheet;
    SourceTable = Stripping;
    UsageCategory = Lists;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("BLNo"; "BLNo")
                {
                    ApplicationArea = all;
                    Caption = 'BL No.';

                    trigger OnLookup(var text: text): Boolean
                    var
                        ManiLine: Record "Manifest Line";
                    begin
                        ManiLine.Reset();
                        ManiLine.SetRange(Received, true);
                        ManiLine.SetRange(Verified, false);
                        ManiLine.SetRange(Released, false);
                        ManiLine.FindFirst();
                        if Page.RunModal(55043, ManiLine) = Action::LookupOK then begin
                            Text := ManiLine."BL No.";
                            exit(true);
                        end;
                        exit(false);
                    end;

                    trigger OnValidate()
                    begin
                        GetManifestLineInfo();
                        CurrPage.Update(false);
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
                field(Stripped; rec.Stripped)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        rec."Stripping Date" := WorkDate;
                        rec."Stripping Time" := Time;
                    end;
                }

                field("Stripping Date"; Rec."Stripping Date")
                {
                    ToolTip = 'Specifies the value of the Stripping Date field.';
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Stripping Time"; Rec."Stripping Time")
                {
                    ToolTip = 'Specifies the value of the Stripping Time field.';
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = all;
                    Editable = false;


                }
                field("Stripping Type"; Rec."Stripping Type")
                {
                    ApplicationArea = all;

                }
                field("Storage Location"; Rec."Storage Location")
                {
                    ApplicationArea = all;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = all;

                }
                field(Bins; Rec.Bins)
                {
                    ApplicationArea = All;
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
                field("Container Size"; Rec."Container Size")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Client Type Code"; Rec."Client Type Code")
                {
                    ToolTip = 'Specifies the value of the  field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Process Type Code"; Rec."Process Type Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Stripping Notes"; Rec."Stripping Notes")
                {
                    ToolTip = 'Specifies the value of the Stripping Notes field.';
                    ApplicationArea = All;
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
            action("Additional Charges")
            {
                Caption = 'Additional Charges';
                ApplicationArea = All;
                RunObject = page "AdditionalCharges Stripping";
                RunPageLink = "Container ID" = field("Shortcut Dimension 4 Code");
            }
            action(Stripping)
            {
                ApplicationArea = All;
                Caption = 'Post Stripping';
                trigger OnAction()
                var
                    STRRec, STRRec2 : Record Stripping;
                    STRLogRec, STRLogRec2 : Record StrippingLog;
                    ManiRec: Record "Manifest Line";

                begin
                    //STRRec.TestField(Stripped,true);

                    STRRec.Reset();
                    STRRec.SetRange(Stripped, true);
                    if STRRec.FindFirst then
                        repeat
                            rec.TestField("Container No./Chassis No.");
                            ManiRec.Reset();
                            ManiRec.SetRange("Job File No.", STRRec."Job File No.");
                            ManiRec.SetRange("Line No.", STRRec."Manifest Line No.");
                            if ManiRec.FindFirst() then begin
                                ManiRec.Stripped := STRRec.Stripped;
                                ManiRec."Stripping Date" := STRRec."Stripping Date";
                                ManiRec."Stripping Time" := STRRec."Stripping Time";
                                ManiRec."Stripping Notes" := STRRec."Stripping Notes";

                                ManiRec.Modify;
                            end;
                        until STRRec.next = 0;
                    UpdateContainer();
                    InsertLog();
                    rec.DeleteAll();
                end;
            }
        }
    }
    var
        BLNo: Code[20];
        // ManiHead: Record "Manifest Header";
        ManiLines: Record "Manifest Line";

    procedure createstrippingManifest()
    var
        MFLine, ML : Record "Manifest Line";
        NoSeriesMgt: Codeunit "No. Series";
        IMSSetup: Record "Ims Setup";
        ImportManifest: record ImportManifest;
        LineNo: Integer;
        JobFileNo: Code[20];
        BlNo: Code[20];
    begin

        MFLine.Reset();
        MFLine.SetRange("Job File No.", Rec."Job File No.");
        if MFLine.FindLast() then
            LineNo := MFLine."Line No." + 10000
        else
            LineNo := 10000;
        MFLine.Init();
        MFLine.Validate("Job File No.", Rec."Job File No.");
        MFLine."Line No." := LineNo;
        MFLine.Insert();
        MFLine.Validate("BL No.", Rec."BL No.");
        MFLine.Validate(Manifested, true);
        MFLine."Shortcut Dimension 4 Code" := Rec."Shortcut Dimension 4 Code";
        MFLine.Validate("Shortcut Dimension 3 Code", Rec."Shortcut Dimension 3 Code");
        MFLine.Validate("Process Type Code", Rec."Process Type Code");
        MFLine.Validate("Parent Container ID", Rec."Shortcut Dimension 4 Code");
        MFLine.Validate("Container Type", Rec."Container Type");
        MFLine.Validate("Global Dimension 2 Code", Rec."Global Dimension 2 Code");
        MFLine.Validate("Container size", Rec."Container size");


        ML.reset();
        ML.SetRange("Shortcut Dimension 4 Code", rec."Shortcut Dimension 4 Code");
        if ML.Find('-') then begin
            MFLine.Validate("CBM Tonage", ML."CBM Tonage");
            MFLine."Job File Date" := ML."Job File Date";

            MFLine.Validate("Clearing Agent", ML."Clearing Agent");
            MFLine.Validate("Consignee No.", ML."Consignee No.");
            MFLine.Validate("Seal/Engine No.", ML."Seal/Engine No.");
            MFLine.Validate("Destination Type", ML."Destination Type");

            MFLine.Validate(Weight, ML.Weight);
            MFLine.Validate("Invoicing Party No.", ML."Invoicing Party No.");
            MFLine.Validate("Port of Discharge", ML."Port of Discharge");
            MFLine.Validate("Port of Shipment", ML."Port of Shipment");
            MFLine.Validate("Container/Chassis No.", ML."Container/Chassis No.");
            MFLine.Validate(Description, Rec.Description);
            MFLine.Validate("Shipping Agent", ML."Shipping Agent");
            MFLine.Validate("Vessel Name", ML."Vessel Name");
            MFLine.Validate("Voyage No.", ML."Voyage No.");
            MFLine.Validate("Expected Arrival Date", ML."Expected Arrival Date");
            MFLine.Validate("Vessel Arrival Date", ML."Vessel Arrival Date");
            MFLine.Validate("Vessel Arrival Time", ML."Vessel Arrival Time");
            MFLine.Validate("Last Sling Date", ML."Last Sling Date");
            MFLine.Validate("Global Dimension 2 Code", ML."Global Dimension 2 Code");
            MFLine.validate("Global Dimension 1 Code", ML."Global Dimension 1 Code");
            MFLine.validate("Client Type Code", ML."Client Type Code");
            MFLine.validate("No. of Bags", ML."No. of Bags");
            MFLine.validate("TBL/MH", ML."TBL/MH");
        end;
        MFLine.Modify();
        ImportManifest.InsertDimensionValues(Rec."Shortcut Dimension 4 Code", MFLine)
    end;

    procedure UpdateContainer()
    var
        DimValRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.get();
        DimValRec.Reset();
        DimValRec.setrange("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
        DimValRec.SetRange(code, rec."Shortcut Dimension 4 Code");
        if DimValRec.FindFirst() then begin
            DimValRec."Container Status" := DimValRec."Container Status"::"In Stock";
            DimValRec.Modify();
        end;
    end;

    procedure GetManifestLineInfo()
    var
        ManifestLineRec: Record "Manifest Line";
        STRRec: Record Stripping;
        LineNo: Integer;
        RecLogRec: Record ReceivingLog;
    begin
        ManifestLineRec.Reset();
        ManifestLineRec.SetRange(ManifestLineRec."BL No.", BLNo);
        ManifestLineRec.setrange(ManifestLineRec.Manifested, true);
        ManifestLineRec.SetRange(ManifestLineRec.Received, true);
        ManifestLineRec.SetRange(ManifestLineRec.Stripped, false);
        if ManifestLineRec.FindFirst() then begin
            LineNo := 10000;
            repeat
                rec.Init();
                rec."Line No." := LineNo;
                rec.Insert();
                rec."Container No./Chassis No." := ManifestLineRec."Container/Chassis No.";
                rec."Container Type" := ManifestLineRec."Container Type";
                rec."Shortcut Dimension 5 Code" := ManifestLineRec."Shortcut Dimension 5 Code";
                rec.Description := ManifestLineRec.Description;
                rec."Job File No." := ManifestLineRec."Job File No.";
                rec."BL No." := ManifestLineRec."BL No.";
                rec."Manifest Line No." := ManifestLineRec."Line No.";
                rec."Global Dimension 2 Code" := ManifestLineRec."Global Dimension 2 Code";
                rec."Global Dimension 1 Code" := ManifestLineRec."Global Dimension 1 Code";
                rec."Shortcut Dimension 4 Code" := ManifestLineRec."Shortcut Dimension 4 Code";
                rec."Process Type Code" := ManifestLineRec."Process Type Code";
                rec."Client Type Code" := ManifestLineRec."Client Type Code";
                rec."Container Size" := ManifestLineRec."Container Size";
                rec."Shortcut Dimension 3 Code" := ManifestLineRec."Shortcut Dimension 3 Code";
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
        STRRec: Record Stripping;
        STRLogRec: Record StrippingLog;
        STRLogRec2: Record StrippingLog;
        AdditionalCharges: Record AdditionalChargesStripping;
        PostedAdditionalCharges: Record "Posted AddCharges Stripping";
        EntryNo: Integer;
    begin
        STRLogRec2.Reset();
        if STRLogRec2.FindLast() then
            EntryNo := STRLogRec2."Entry No." + 1
        else
            EntryNo := 1;
        STRRec := Rec;
        STRRec.Reset();
        IF STRRec.FindSet() then begin

            repeat
                STRLogRec.Init();
                STRLogRec."Entry No." := EntryNo;
                STRLogRec."Stripping No." := STRRec."Stripping No.";
                STRLogRec."Line No." := STRRec."Line No.";
                STRLogRec."Stripping Date" := STRRec."Stripping Date";
                STRLogRec."Stripping Time" := STRRec."Stripping Time";
                STRLogRec."Container No./Chassis No." := STRRec."Container No./Chassis No.";
                STRLogRec."Global Dimension 1 Code" := STRRec."Global Dimension 1 Code";
                STRLogRec."Shortcut Dimension 4 Code" := STRRec."Shortcut Dimension 4 Code";
                STRLogRec."Job File No." := STRRec."Job File No.";
                STRLogRec."BL No." := rec."BL No.";
                STRLogRec."Container Type" := STRRec."Container Type";
                STRLogRec."Shortcut Dimension 5 Code" := STRRec."Shortcut Dimension 5 Code";
                STRLogRec.Description := STRRec.Description;

                STRLogRec."Stripping Notes" := STRRec."Stripping Notes";
                STRLogRec."Shipper Seal" := STRRec."Shipper Seal";
                STRLogRec.Insert();
                EntryNo := EntryNo + 1;

                AdditionalCharges.Reset();
                AdditionalCharges.SetRange("Container ID", STRLogRec."Shortcut Dimension 4 Code");
                IF AdditionalCharges.FindFirst() Then begin
                    repeat
                        PostedAdditionalCharges.Init();
                        PostedAdditionalCharges."Stripping Entry No." := STRLogRec."Entry No.";

                        PostedAdditionalCharges."Container ID" := AdditionalCharges."Container ID";
                        PostedAdditionalCharges."Line No." := AdditionalCharges."Line No.";
                        PostedAdditionalCharges."Stripping Charges" := AdditionalCharges."Stripping Charges";
                        PostedAdditionalCharges.insert;
                        AdditionalCharges.Delete();
                    until AdditionalCharges.next = 0;
                end;
            UNTIL STRRec.Next = 0;
            Message('Stripping Successfully');
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        rec.DeleteAll();
    end;
}



















