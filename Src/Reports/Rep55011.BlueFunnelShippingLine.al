report 55011 "Blue Funnel Shipping Line"
{
    Caption = 'Shipping Line Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Manifest Line"; "Manifest Line")
        {
            trigger OnPreDataItem()
            begin
                SetRange("Date Received", StartDate);
                setrange(Received, True);
                if ShippingAgent <> '' then
                    SetRange("Shipping Agent", ShippingAgent);
            end;

            trigger OnAfterGetRecord()
            begin
                //MakeBodyStock("Manifest Line");
            end;
        }

        dataitem("Manifest Line Delivered"; "Manifest Line")
        {
            trigger OnPreDataItem()
            begin
                SetRange("Date Released", StartDate);
                SetRange(Released, True);
                if ShippingAgent <> '' then
                    SetRange("Shipping Agent", ShippingAgent);
            end;

            trigger OnAfterGetRecord()
            begin
                //MakeBodyDelivered("Manifest Line Delivered");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShippingAgent; ShippingAgent)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping Agent';
                        TableRelation = "Shipping Agent";
                    }
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Date as AT';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        if StartDate = 0D then
            StartDate := Today - 1;
    end;

    trigger OnPostReport()
    begin
        CreateExcelBook();
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        StartDate: Date;
        ShippingAgent: Code[50];
        SNo: Integer;
        SNo2: Integer;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;

    local procedure CreateExcelBook()
    var
        ManifestLine: Record "Manifest Line";
        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        ShippingAgentRec: Record "Shipping Agent";
        FileName: Text;
        FileFilter: Text;
    begin
        FileName := ShippingAgent + '_Shipping_Report_' + Format(Today, 0, '<Day,2><Month,2><Year4>') + '.xlsx';
        FileFilter := 'Excel Files (*.xlsx)|*.xlsx';

        // ── Step 1: Create workbook ──
        TempExcelBuffer.CreateNewBook('Stock');

        // ── Step 2: Build and write Stock sheet ──
        SNo := 0;
        TempExcelBuffer.SelectOrAddSheet('Stock');
        MakeHeaderStock();

        ManifestLine.Reset();
        ManifestLine.SetRange("Date Received", StartDate);
        ManifestLine.setrange(Received, True);
        if ShippingAgent <> '' then
            ManifestLine.SetRange("Shipping Agent", ShippingAgent);
        if ManifestLine.FindSet() then
            repeat
                MakeBodyStock(ManifestLine);
            until ManifestLine.Next() = 0;

        TempExcelBuffer.WriteSheet('Stock', CompanyName, UserId);
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.ClearNewRow();

        // ── Step 3: Build and write Delivered sheet ──
        SNo2 := 0;
        TempExcelBuffer.SelectOrAddSheet('Delivered');
        MakeHeaderDelivered();

        ManifestLine.Reset();
        ManifestLine.SetRange("Date Released", StartDate);
        ManifestLine.setrange(Released, True);
        if ShippingAgent <> '' then
            ManifestLine.SetRange("Shipping Agent", ShippingAgent);
        if ManifestLine.FindSet() then
            repeat
                MakeBodyDelivered(ManifestLine);
            until ManifestLine.Next() = 0;

        TempExcelBuffer.WriteSheet('Delivered', CompanyName, UserId);

        // ── Step 4: CloseBook FIRST ──
        TempExcelBuffer.CloseBook();

        // ── Step 5: Stream ──
        TempBlob.CreateOutStream(OutStr);
        TempExcelBuffer.SaveToStream(OutStr, true);

        // ── Step 6: Download ──
        TempBlob.CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', FileFilter, FileName);

        // ── Step 7: Email ──
        if not ShippingAgentRec.Get(ShippingAgent) then
            exit;
        if ShippingAgentRec."email" = '' then
            exit;

        TempBlob.CreateInStream(InStr);

        Clear(EmailMsg);
        EmailMsg.Create(
            ShippingAgentRec."email",
            ShippingAgentRec.Name + ' — Shipping Line Report ' + Format(StartDate, 0, '<Day,2> <Month Text> <Year4>'),
            'Dear ' + ShippingAgentRec.Name + ',<br/><br/>Please find attached the shipping line report as at ' +
            Format(StartDate, 0, '<Day,2> <Month Text> <Year4>') + '.<br/><br/>Regards,<br/>' + CompanyName,
            true
        );

        if ShippingAgentRec."email2" <> '' then
            EmailMsg.AddRecipient(Enum::"Email Recipient Type"::Cc, ShippingAgentRec."email2");

        EmailMsg.AddAttachment(
            FileName,
            'application/octet-stream',
            InStr
        );

        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
        Message('Report emailed successfully to %1.', ShippingAgentRec."email");
    end;

    local procedure MakeHeaderStock()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(
            "Manifest Line"."Shipping Agent Name" + ' SHIPPING LINE STOCK REPORT',
            false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('NO', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('BL NO', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('CONTAINER NO', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('SIZE', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('SEAL NUMBER', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('WEIGHT', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('SICD IN DATE', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('STATUS (FULL/ EMPTY)', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
    end;

    local procedure MakeHeaderDelivered()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(
            "Manifest Line"."Shipping Agent Name" + ' SHIPPING LINE DELIVERED REPORT',
            false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('NO', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('BL NO', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('CONTAINER NO', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('SIZE', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('SEAL NUMBER', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('WEIGHT', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('SICD OUT DATE', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('STATUS (FULL/ EMPTY)', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
    end;

    local procedure MakeBodyStock(ManifestLine: Record "Manifest Line")
    begin
        SNo += 1;
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(SNo, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ManifestLine."BL No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Container/Chassis No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Shortcut Dimension 5 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Seal/Engine No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine.Weight, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ManifestLine."Date Received", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(ManifestLine."Shortcut Dimension 6 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeBodyDelivered(ManifestLine: Record "Manifest Line")
    begin
        SNo2 += 1;
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(SNo2, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ManifestLine."BL No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Container/Chassis No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Shortcut Dimension 5 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine."Seal/Engine No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine.Weight, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ManifestLine."Date Released", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(ManifestLine."Shortcut Dimension 6 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;
}