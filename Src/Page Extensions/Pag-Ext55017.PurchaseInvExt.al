pageextension 55017 PurchaseInvExt extends "Purchase Invoice"
{
    layout
    {
        addlast(General)
        {
            field("BL No"; Rec."BL No")
            {
                ApplicationArea = All;
                trigger OnLookup(var text: text): Boolean
                var
                    ManiLine: Record "Manifest Line";
                begin
                    ManiLine.Reset();
                    ManiLine.SetRange(Verified, false);
                    ManiLine.SetRange(Released, false);
                    ManiLine.FindFirst();
                    if Page.RunModal(55043, ManiLine) = Action::LookupOK then begin
                        Text := ManiLine."BL No.";
                        exit(true);
                    end;
                    exit(false);
                end;

            }
            field("CU Number"; Rec."CU Number")
            {
                caption = 'CU Number';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addbefore(Dimensions)
        {
            action("&Import")
            {
                Caption = '&Import Purchase lines';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Import data from excel.';

                trigger OnAction()
                var
                begin
                    //if BatchName = '' then
                    //  Error(BatchISBlankMsg);
                    ReadExcelSheet();
                    ImportExcelData();
                end;
            }
            action("Load Lines")
            {
                Caption = '&Load Purchase lines';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    PurchLine: record "Purchase Line";
                    LineNo: Integer;
                    ManifestLine: record "Manifest Line";
                    TempSelectedContainers: record "Manifest Line" temporary;
                    PurchaseLookup: page "Purchase Lookup";
                begin
                    ManifestLine.Reset();
                    ManifestLine.SetRange(Released, False);
                    ManifestLine.setrange("Container lock", False);
                    ManifestLine.SetRange("BL No.", rec."BL No");
                    ManifestLine.SetAutoCalcFields("KPA Charges Calculated");
                    ManifestLine.SetRange("KPA Charges Calculated", False);
                    if ManifestLine.FindSet() then
                        repeat
                            TempSelectedContainers.init();
                            //TempSelectedContainers.TransferFields(ManifestLine);
                            TempSelectedContainers."Global Dimension 1 Code" := ManifestLine."Global Dimension 1 Code";
                            TempSelectedContainers."Global Dimension 2 Code" := ManifestLine."Global Dimension 2 Code";
                            TempSelectedContainers."Shortcut Dimension 3 Code" := ManifestLine."Shortcut Dimension 3 Code";
                            TempSelectedContainers."Shortcut Dimension 4 Code" := ManifestLine."Shortcut Dimension 4 Code";
                            TempSelectedContainers."Shortcut Dimension 5 Code" := ManifestLine."Shortcut Dimension 5 Code";
                            TempSelectedContainers."Shortcut Dimension 6 Code" := ManifestLine."Shortcut Dimension 6 Code";
                            TempSelectedContainers."Job File No." := ManifestLine."Job File No.";
                            TempSelectedContainers."BL No." := ManifestLine."BL No.";
                            TempSelectedContainers."Consignee No." := ManifestLine."Consignee No.";
                            TempSelectedContainers."Consignee Name" := ManifestLine."Consignee Name";
                            TempSelectedContainers."Parent Container ID" := ManifestLine."Parent Container ID";
                            TempSelectedContainers."Container/Chassis No." := ManifestLine."Container/Chassis No.";
                            TempSelectedContainers."Line No." := ManifestLine."Line No.";
                            TempSelectedContainers."Date Received" := ManifestLine."Date Received";
                            TempSelectedContainers."Clearing Agent" := ManifestLine."Clearing Agent";
                            TempSelectedContainers."Destination Type" := ManifestLine."Destination Type";
                            TempSelectedContainers."Container Type" := ManifestLine."Container Type";
                            TempSelectedContainers.Insert();
                        until ManifestLine.Next() = 0;
                    clear(PurchaseLookup);
                    PurchaseLookup.SetTableView(TempSelectedContainers);

                    PurchaseLookup.SetRecord(TempSelectedContainers);
                    PurchaseLookup.GetGPNo(Rec."No.");
                    PurchaseLookup.LookupMode(true);
                    if PurchaseLookup.RunModal = ACTION::LookupOK then begin
                    end;


                end;
            }

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


    local procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile <> '' then begin
            FileName := FileMgt.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(IStream);
        end else
            Error(NoFileFoundMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, SheetName);
        TempExcelBuffer.ReadSheet();
    end;

    local procedure ImportExcelData()
    var
        PurchLine: Record "Purchase Line";
        ManifestLine: Record "Manifest Line";
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
        ShortcutDimCode: array[8] of Code[20];
    begin
        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", rec."Document Type");
        PurchLine.SetRange("Document No.", rec."No.");
        if PurchLine.FindLast() then
            LineNo := PurchLine."Line No." + 10000
        else
            LineNo := 10000;
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then begin
            MaxRowNo := TempExcelBuffer."Row No.";
        end;

        for RowNo := 2 to MaxRowNo do begin
            LineNo := LineNo + 10000;
            PurchLine.Init();
            //Evaluate(PurchLine."Batch Name", BatchName);
            PurchLine.validate("Document Type", rec."Document Type");
            PurchLine.Validate("Document No.", rec."No.");
            PurchLine.Validate("Line No.", LineNo);
            PurchLine.Validate(Type, PurchLine.Type::Item);
            Evaluate(PurchLine."No.", GetValueAtCell(RowNo, 1));
            PurchLine.Validate(PurchLine."No.");
            Evaluate(PurchLine.Quantity, '1');
            PurchLine.Validate(Quantity);
            Evaluate(PurchLine."Direct Unit Cost", GetValueAtCell(RowNo, 2));
            PurchLine.Validate("Direct Unit Cost");
            Evaluate(PurchLine."Shortcut Dimension 4 Code", GetValueAtCell(RowNo, 3));
            PurchLine.ValidateShortcutDimCode(4, PurchLine."Shortcut Dimension 4 Code");
            PurchLine.Validate(PurchLine."Shortcut Dimension 4 Code");
            PurchLine.Insert();
            ManifestLine.Reset();
            ManifestLine.SetRange("Shortcut Dimension 4 Code", PurchLine."Shortcut Dimension 4 Code");
            if ManifestLine.FindFirst() then begin
                ShortcutDimCode[1] := ManifestLine."Global Dimension 1 Code";
                ShortcutDimCode[2] := ManifestLine."Global Dimension 2 Code";
                ShortcutDimCode[3] := ManifestLine."Shortcut Dimension 3 Code";
                ShortcutDimCode[4] := ManifestLine."Shortcut Dimension 4 Code";
                ShortcutDimCode[5] := ManifestLine."Shortcut Dimension 5 Code";
                ShortcutDimCode[6] := ManifestLine."Shortcut Dimension 6 Code";
                PurchLine.ValidateShortcutDimCode(1, ShortcutDimCode[1]);
                PurchLine.ValidateShortcutDimCode(2, ShortcutDimCode[2]);
                PurchLine.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                PurchLine.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                PurchLine.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                PurchLine.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                PurchLine.Validate(PurchLine."Shortcut Dimension 2 Code", ShortcutDimCode[2]);
            end;
            PurchLine.Modify();
        end;
        Message(ExcelImportSucess);
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin

        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;
}

