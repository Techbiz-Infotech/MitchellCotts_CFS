page 55124 ProfomaAPI
{
    APIGroup = 'apiGroup';
    APIPublisher = 'Techbizinfotech';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'profomaAPI';
    DelayedInsert = true;
    EntityName = 'ProfomaAPI';
    EntitySetName = 'ProfomaAPI';
    PageType = API;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = const(Order));


    layout
    {
        area(content)
        {
            field(No; Rec."No.") { }
            field(VendorNo; Rec."Buy-from Vendor No.") { }
            field(VendorName; Rec."Pay-to Name") { }
            field(VendorInvoiceNo; Rec."Vendor Invoice No.") { }
            field(PostingDate; Rec."Posting Date") { }
            field(Amount; Rec.Amount) { }
            field(status; Rec.Status)
            {
                Caption = 'Status';
            }

            field(AmountIncludingVAT; Rec."Amount Including VAT") { }
            field(TotalVat; Rec."Amount Including VAT" - Rec.Amount) { }
            // field(U_CUNo; Rec.U_CUNo) { }
            // field(QRLink; Rec.QRLink) { }
            // field(U_Serial; Rec.U_Serial) { }
            // field(U_Date; Rec.U_Date) { }
            // field(KraPinNo; Rec."Kra Pin No") { }
            field(SystemId; Rec.SystemId) { }

            part(Lines; "Purchase Line API")
            {
                EntityName = 'Profoma';
                EntitySetName = 'Profoma';
                SubPageLink =
                              "Document No." = field("No.");
            }
        }
    }
}

page 55125 "Purchase Line API"
{
    PageType = API;
    Caption = 'Purchase Invoice Line API';
    APIPublisher = 'Techbizinfotech';
    APIGroup = 'apiGroup';
    APIVersion = 'v1.0';
    EntityName = 'Profoma';
    EntitySetName = 'Profoma';
    SourceTable = "Purchase Line";
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field(ItemNo; Rec."No.") { }
            field(Description; Rec.Description) { }
            field(Quantity; Rec.Quantity) { }
            field("BLNo"; Rec."BL No") { }
            field("ContainerID"; Rec."Shortcut Dimension 4 Code") { }
            field(UnitCost; Rec."Direct Unit Cost") { }
            field(VATProdPostingGroup; Rec."VAT Prod. Posting Group") { }
            field(VAT; Rec."VAT %") { Caption = 'VAT Rate'; }
            field(VATAmount; GetVATAmount()) { }
            field(LineAmount; Rec."Line Amount") { }
            field(SystemId; Rec.SystemId) { }
        }
    }

    local procedure GetVATAmount(): Decimal
    begin
        exit((Rec."Line Amount" * Rec."VAT %") / 100);
    end;
}