page 55211 PurchaseInvKPI
{
    PageType = API;
    Caption = 'PurchaseInvKPI';
    APIPublisher = 'Techbizinfotech';
    APIGroup = 'apiGroup';
    APIVersion = 'v1.0';
    EntityName = 'PurchaseInvKPI';
    EntitySetName = 'PurchaseInvKPI';
    SourceTable = "Purch. Inv. Header";
    //SourceTableView = where("Document Type" = const(Invoice));
    ODataKeyFields = SystemId;
    DelayedInsert = true;

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
            field(AmountIncludingVAT; Rec."Amount Including VAT") { }
            field(TotalVat; Rec."Amount Including VAT" - Rec.Amount) { }
            // field(U_CUNo; Rec.U_CUNo) { }
            // field(QRLink; Rec.QRLink) { }
            // field(U_Serial; Rec.U_Serial) { }
            // field(U_Date; Rec.U_Date) { }
            // field(KraPinNo; Rec."Kra Pin No") { }
            field(SystemId; Rec.SystemId) { }

            part(Lines; "Purchase Invoice Line API")
            {
                EntityName = 'Purchline';
                EntitySetName = 'Purchlines';
                SubPageLink =
                              "Document No." = field("No.");
            }
        }
    }
}

page 55212 "Purchase Invoice Line API"
{
    PageType = API;
    Caption = 'Purchase Invoice Line API';
    APIPublisher = 'Techbizinfotech';
    APIGroup = 'apiGroup';
    APIVersion = 'v1.0';
    EntityName = 'Purchline';
    EntitySetName = 'Purchlines';
    SourceTable = "Purch. Inv. Line";
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