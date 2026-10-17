page 55122 "Purchase Lookup"
{

    ApplicationArea = All;
    Caption = 'Manifest lookup';
    PageType = List;
    SourceTable = "Manifest Line";
    DeleteAllowed = false;
    //Editable = False;
    SourceTableTemporary = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                    Visible = true;
                    Editable = false;
                    // trigger OnAssistEdit()
                    // varparent
                    //     myInt: Integer;
                    // begin
                    //     if rec.OnAssistEdit(xRec) then
                    //         CurrPage.Update();
                    // end;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Visible = true;
                    Editable = false;
                }
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Job File Date"; rec."Job File Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job File Date field.';
                    Editable = false;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Received; rec.Received)
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Date Received"; Rec."Date Received")
                {
                    ToolTip = 'Specifies the value of the Date Received field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Received Time"; rec."Received Time")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field(Released; rec.Released)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Date Released"; Rec."Date Released")
                {
                    ToolTip = 'Specifies the value of the Date Released field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Charge ID"; Rec."Charge ID")
                {
                    ToolTip = 'Specifies the value of the Charge ID field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field(Manifested; Rec.Manifested)
                {
                    ToolTip = 'Specifies the value of the Manifested field.';
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Consignee No."; rec."Consignee No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Invoicing Party No."; rec."Invoicing Party No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Container Status"; rec."Container Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the container Status field.';
                    //Editable = SPEditable;
                    Editable = false;
                }

                field("TBL/MH"; Rec."TBL/MH")
                {
                    ToolTip = 'Specifies the value of the TBL/MH field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Container/Chassis No."; Rec."Container/Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container/Chassis No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }


                field("Seal/Engine No."; Rec."Seal/Engine No.")
                {
                    ToolTip = 'Specifies the value of the Seal/Engine No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customs Seal No."; Rec."Customs Seal No.")
                {
                    ToolTip = 'Specifies the value of the Customs Seal No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        MarksEdiatable();
                        ParentEdiatable();
                    end;
                }
                field("Landing Date"; rec."Landing Date")
                {
                    ToolTip = 'Specifies the value of the Landing date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Landing Time"; rec."Landing Time")
                {
                    ToolTip = 'Specifies the value of the Landing Time field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Marks; Rec.Marks)
                {
                    ToolTip = 'Specifies the value of the Marks field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Parent Container ID"; Rec."Parent Container ID")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger onvalidate()
                    var
                        myInt: Integer;
                    begin

                    end;
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
                field("Container lock"; Rec."Container lock")
                {
                    ToolTip = 'Specifies the value of the Container lock field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("CBM Tonage"; Rec."CBM Tonage")
                {
                    ToolTip = 'Specifies the value of the CBM Tonage field.';
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.';
                    ApplicationArea = All;
                    Editable = false;

                }
                field("CBM-Wt Difference"; Rec."CBM-Wt Difference")
                {
                    ToolTip = 'Specifies the value of the CBM-Wt Difference field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Port of Shipment"; Rec."Port of Shipment")
                {
                    ToolTip = 'Specifies the value of the Port of Shipment field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                    ToolTip = 'Specifies the value of the Port of Discharge field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ToolTip = 'Specifies the value of the Destination Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Final Destination"; Rec."Final Destination")
                {
                    ToolTip = 'Specifies the value of the Final Destination field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Allocated Position"; rec."Allocated Position")
                {
                    ToolTip = 'Specifies the value of the Allocated Position';
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Transporter; Rec.Transporter)
                {
                    ToolTip = 'Specifies the value of the Transporter field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ToolTip = 'Specifies the value of the Transporter Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Driver ID"; Rec."Driver ID")
                {
                    ToolTip = 'Specifies the value of the Driver ID field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Vehicle; Rec.Vehicle)
                {
                    ToolTip = 'Specifies the value of the Vehicle field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Delivery Order No."; Rec."Delivery Order No.")
                {
                    ToolTip = 'Specifies the value of the Delivery Order No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Received By"; Rec."Received By")
                {
                    ToolTip = 'Specifies the value of the Received By field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Verified; rec.Verified)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Verification Type"; Rec."Verification Type")
                {
                    ToolTip = 'Specifies the value of the Verification Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Verification Print Date"; Rec."Verification Print Date")
                {
                    ToolTip = 'Specifies the value of the Verification Print Date field.';
                    ApplicationArea = All;
                    //Editable = false;
                    Visible = false;

                }
                field("Verification Time"; rec."Verification Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Verification Notes"; rec."Verification Notes")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("No. of Bags"; Rec."No. of Bags")
                {
                    ToolTip = 'Specifies the value of the No. of Bags field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. of Bags Released"; Rec."No. of Bags Released")
                {
                    ToolTip = 'Specifies the value of the No. of Bags Released field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Remaining Bags"; Rec."Remaining Bags")
                {
                    ToolTip = 'Specifies the value of the Remaining Bags field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Custom Entry No."; rec."Custom Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Discharge Date"; rec."Discharge Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ICDN In-Date"; rec."ICDN In-Date")
                {
                    ApplicationArea = All;
                }
                field("Railed Date"; rec."Railed Date")
                {
                    ApplicationArea = All;
                }
                field("SICD In-Date"; rec."SICD In-Date")
                {
                    ApplicationArea = All;

                }
                field("Docs Received Date"; rec."Docs Received Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                }
                field("Sales Quote No."; rec."Sales Quote No.")
                {
                    ApplicationArea = All;
                    LookupPageId = "Sales Quotes";
                }
                field("Oppertunity No."; rec."Oppertunity No.")
                {
                    ApplicationArea = All;
                }
                field("Client Reference No."; rec."Client Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent"; Rec."Shipping Agent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Agent field.';

                }
                field("Shipping Agent Name"; rec."Shipping Agent Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Agent Name field.';

                }
                field("Vessel Name"; rec."Vessel Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Vessel Name field.';
                }
                field("Vessel Arrival Date"; rec."Vessel Arrival Date")
                {
                    ApplicationArea = all;

                    ToolTip = 'Specifies the value of the Vessel Arrival Date field.';
                }
                field("Vessel Arrival Time"; rec."Vessel Arrival Time")
                {
                    ApplicationArea = all;

                    ToolTip = 'Specifies the value of the Vessel Arrival Time field.';
                }
                field("Voyage No."; rec."Voyage No.")
                {
                    ApplicationArea = all;

                    ToolTip = 'Specifies the value of the Voyage No. field.';
                }
                field("Last Sling Date"; rec."Last Sling Date")
                {
                    ApplicationArea = all;

                    ToolTip = 'Specifies the value of the Last Sling Date field.';
                }
                field("Expected Arrival Date"; rec."Expected Arrival Date")
                {
                    ApplicationArea = all;

                    ToolTip = 'Specifies the value of the Expected Arrival Date field.';
                }


                field("Other remarks"; rec."Other remarks")
                {
                    ApplicationArea = All;
                }
                field(Stripped; Rec.Stripped)
                {
                    ApplicationArea = All;
                }

                field("User ID"; rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("KPA Charges Calculated"; rec."KPA Charges Calculated")
                {
                    ToolTip = 'Specifies the value of the KPA Charges Calculated field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {


        }
    }

    var
        BatchName: Code[10];
        FileName: Text[100];
        SheetName: Text[100];

        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        BatchISBlankMsg: Label 'Batch name is blank';
        ExcelImportSucess: Label 'Excel is successfully imported.';
        JobfileNo: Code[20];



    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        TempCLE: Record "Manifest Line" temporary;
        NetProfit: decimal;
        PurchLine: record "Purchase Line";
        Purchheader: record "Purchase Header";
        LineNo: Integer;
        ManifestLine: record "Manifest Line";
        TempSelectedContainers: record "Manifest Line" temporary;
        primarysetup: record "IMS Setup";
        Item: record Item;

    begin

        if CloseAction in [action::OK, action::LookupOK] then begin
            primarysetup.Get();
            primarysetup.TestField("Category Code Wharfage");
            primarysetup.TestField("Category for Shorehandling");
            CurrPage.SetSelectionFilter(Rec);
            if Rec.FINDSET then
                repeat
                    TempCLE := Rec;
                    TempCLE.INSERT;
                    TempCLE.Modify();

                until Rec.NEXT = 0;

            Purchheader.Reset();
            Purchheader.SetRange("No.", GPNo);
            if Purchheader.FindFirst() then begin
                PurchLine.Reset();
                PurchLine.SetRange("Document No.", Purchheader."No.");
                if PurchLine.FindSet() then begin
                    if Confirm('Do you want to delete the existing lines?', true) then
                        PurchLine.DeleteAll()
                    else
                        exit;
                end;
            end;


            If TempCLE.FindSet() then
                repeat
                    Item.Reset();
                    Item.SetFilter("Item Category Code", '%1|%2', primarysetup."Category Code Wharfage", primarysetup."Category for Shorehandling");
                    if Item.FindSet() then
                        repeat
                            Rec.TestField("BL No.");
                            PurchLine.Reset();
                            PurchLine.SetRange("Document Type", PurchLine."Document Type"::Invoice);
                            PurchLine.SetRange("Document No.", GPNo);
                            if PurchLine.FindLast() then
                                LineNo := PurchLine."Line No." + 10000
                            else
                                LineNo := 10000;

                            PurchLine.Init();
                            PurchLine.validate("Document Type", PurchLine."Document Type"::Invoice);
                            PurchLine.Validate("Document No.", GPNo);
                            PurchLine.Validate("Line No.", LineNo);
                            PurchLine.Validate(Type, PurchLine.Type::Item);
                            PurchLine.Validate(PurchLine."No.", Item."No.");
                            PurchLine.Validate(Quantity, 1);
                            PurchLine.Validate(PurchLine."Shortcut Dimension 4 Code", Rec."Shortcut Dimension 4 Code");
                            PurchLine.Validate("BL No", Rec."BL No.");
                            PurchLine.Validate("Shortcut Dimension 1 Code", rec."Global Dimension 1 Code");
                            PurchLine.Validate("Shortcut Dimension 2 Code", rec."Global Dimension 2 Code");
                            PurchLine.ValidateShortcutDimCode(1, rec."Global Dimension 1 Code");
                            PurchLine.ValidateShortcutDimCode(2, rec."Global Dimension 2 Code");
                            PurchLine.ValidateShortcutDimCode(3, rec."Shortcut Dimension 3 Code");
                            PurchLine.Insert();

                        until Item.Next() = 0;
                until TempCLE.Next = 0;



        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        MarksEdiatable();
        LandingEdiatable();
        ContainerLockEditable();
        //Rec.GetHeadDetails();
    end;

    trigger onopenpage()
    var
        myInt: Integer;
    begin
        MarksEdiatable();
        ParentEdiatable();
        LandingEdiatable();
        //Rec.GetHeadDetails();
        ContainerEdiatable();
        ContainerLockEditable();
        CheckPayments();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        MarksEdiatable();
        ParentEdiatable();
        LandingEdiatable();
        ContainerLockEditable();
        //Rec.GetHeadDetails();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        MarksEdiatable;
        ParentEdiatable();
        LandingEdiatable();
        ContainerLockEditable();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Error('You can not Create new records Manually. Please use Import Worksheet to create the Manifest Lines');
        CurrPage.Update(false);
    end;

    local procedure MarksEdiatable()
    var
        myInt: Integer;
    begin
        IF Rec."Shortcut Dimension 3 Code" = 'LOOSE' then
            MarksEdit := true
        else
            MarksEdit := false;
        //CurrPage.Update(false);
    end;

    local procedure ParentEdiatable()
    begin
        IF (Rec."Shortcut Dimension 3 Code" = 'UNIT') OR (Rec."Shortcut Dimension 3 Code" = 'LOOSE') or (Rec."Shortcut Dimension 4 Code" = 'STRIPPED UNIT') then
            ParentEdit := true
        else
            ParentEdit := false;
        //CurrPage.Update(false);
    end;

    local procedure LandingEdiatable()
    begin
        IF rec."Container Type" = rec."Container Type"::Reefer then
            LandingEdit := true
        else
            LandingEdit := false;
        //CurrPage.Update(false);
    end;

    local procedure ContainerEdiatable()
    begin
        //if (UserId = 'GROUP.AUDIT') or (UserId = 'TECHBIZINFOTECH') or (UserId = 'SHILLAH') then
        //ContainerEdit := true
        //else
        //ContainerEdit := false;
        //CurrPage.Update(false);
    end;

    local procedure ContainerLockEditable()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if UserSetup."Container lock Edit" then
            ContainerLockEdit := true
        else
            ContainerLockEdit := false;
        //CurrPage.Update(false);
    end;

    procedure OnAssistEdit(ManifestRec: Record "Manifest Line"): Boolean
    var
        ManiRec: Record "Manifest Line";
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";

    begin
        ManiRec := Rec;
        ImsSetup.Get;
        ImsSetup.TestField("Job File Nos");
        if NoSeriesMgt.LookupRelatedNoSeries(ImsSetup."Job File Nos", ManifestRec."No.Series", Rec."No.Series") then begin
            NoSeriesMgt.GetNextNo(Rec."Job File No.");
            Rec := ManiRec;
            exit(true);
        end;
    end;


    //for stripped units


    procedure GetGPNo(var NewGPNo: Code[20])
    begin
        GPNo := NewGPNo;
    end;





    procedure SetTempManifest(var TempManifest: Record "Manifest Line" temporary)
    begin
        Rec.DeleteAll();
        Rec.Copy(TempManifest, true);

    end;


    procedure CheckPayments()
    var

        SalesInvLine: Record "Sales Invoice Line";
        EntryNo, LineNo : Integer;
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        RecCustLedgEntry: Record "Cust. Ledger Entry";
        PageInvoiceStatus: Page InvoiceStatusList;
        PrevDocNo, PrevContainerNo : Code[20];
        Purchasehead: record "Purchase Header";
        ManifestLine: Record "Manifest Line";
        ManifestLookup: Page "Manifest lookup";
        TempSelectedContainers: record "Manifest Line" temporary;

    begin
        Purchasehead.Reset();
        Purchasehead.SetRange("No.", GPNo);
        Purchasehead.SetRange("Document Type", Purchasehead."Document Type"::Invoice);
        If Purchasehead.FindFirst() then begin



            ManifestLine.Reset();
            ManifestLine.SetRange("BL No.", Purchasehead."BL No");
            ManifestLine.SetRange(Released, false);
            ManifestLine.SetRange("Container lock", False);
            if ManifestLine.FindSet() then begin
                repeat
                    Rec.init();
                    Rec."Global Dimension 1 Code" := ManifestLine."Global Dimension 1 Code";
                    Rec."Global Dimension 2 Code" := ManifestLine."Global Dimension 2 Code";
                    Rec."Shortcut Dimension 3 Code" := ManifestLine."Shortcut Dimension 3 Code";
                    Rec."Shortcut Dimension 4 Code" := ManifestLine."Shortcut Dimension 4 Code";
                    Rec."Shortcut Dimension 5 Code" := ManifestLine."Shortcut Dimension 5 Code";
                    Rec."Shortcut Dimension 6 Code" := ManifestLine."Shortcut Dimension 6 Code";
                    Rec."Job File No." := ManifestLine."Job File No.";
                    Rec."BL No." := ManifestLine."BL No.";
                    Rec."Parent Container ID" := ManifestLine."Parent Container ID";
                    Rec."Consignee No." := ManifestLine."Consignee No.";
                    Rec."Consignee Name" := ManifestLine."Consignee Name";
                    Rec."Container/Chassis No." := ManifestLine."Container/Chassis No.";
                    Rec."Line No." := ManifestLine."Line No.";
                    Rec."Date Received" := ManifestLine."Date Received";
                    Rec."Clearing Agent" := ManifestLine."Clearing Agent";
                    Rec."Destination Type" := ManifestLine."Destination Type";
                    Rec."Container Type" := ManifestLine."Container Type";
                    Rec.Insert();
                until ManifestLine.Next() = 0;
            end;
        end;

    End;



    procedure GetLastTempLineNo(var TempTable: Record "Manifest Line" temporary) LineNo: Integer
    begin
        // Set the current key so FindLast() sorts by Line No
        TempTable.SetCurrentKey("Line No.");

        if TempTable.FindLast() then
            exit(TempTable."Line No.")
        else
            exit(0);
    end;

    procedure GetReceiptNo()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        ApplyCustLedgEntry: Record "Cust. Ledger Entry";
        GatePassLineRec: Record "Gate Pass Out Line";
    begin
        GatePassLineRec.Reset();
        GatePassLineRec.SetRange("Gate Pass No.", GPNo);
        if GatePassLineRec.FindSet() then begin
            repeat
                CustLedgEntry.Reset();
                CustLedgEntry.SetRange("Document No.", GatePassLineRec."Invoice No.");
                CustLedgEntry.SetRange(Open, false);
                IF CustLedgEntry.FindFirst() then begin
                    ApplyCustLedgEntry.Reset();
                    ApplyCustLedgEntry.SetRange("Entry No.", CustLedgEntry."Closed by Entry No.");
                    if ApplyCustLedgEntry.FindFirst() then begin
                        GatePassLineRec."Receipt No." := ApplyCustLedgEntry."Document No.";
                        GatePassLineRec.Modify();
                    end;
                end else begin
                    Message('receipt not found');
                    exit;
                end;
            //exit;
            until GatePassLineRec.next = 0;
        end;
    end;

    var
        GPHead: Record "Gate Pass Out";
        GPLine, GatePassLine : Record "Gate Pass Out Line";
        GPNo: code[50];
        SPEditable, ContainerLockEdit, LandingEdit, ContainerEdit, ParentEdit, MarksEdit : Boolean;






}

