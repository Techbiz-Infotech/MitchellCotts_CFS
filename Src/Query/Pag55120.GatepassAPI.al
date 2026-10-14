page 55214 GatepassAPI
{
    PageType = API;
    APIPublisher = 'Techbizinfotech';
    APIGroup = 'apiGroup';
    APIVersion = 'v1.0';
    Caption = 'gatepassAPI';
    EntityName = 'GatePassAPI';
    EntitySetName = 'GatePassAPI';
    SourceTable = "Gate Pass Out";
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId) { Editable = false; }
                field(gatePassNo; Rec."Gate Pass No.") { Caption = 'Gate Pass No.'; }
                field(activityDate; Rec."Activity Date") { Caption = 'Activity Date'; }
                field(activityTime; Rec."Activity Time") { Caption = 'Activity Time'; }
                field(agentName; Rec."Agent Name") { Caption = 'Agent Name'; }
                field(agentPortPass; Rec."Agent Port Pass") { Caption = 'Agent Port Pass'; }
                field(approved; Rec.Approved) { Caption = 'Approved'; }
                field(approvedBy; Rec."Approved By") { Caption = 'Approved By'; }
                field(approvedDateTime; Rec."Approved Date Time") { Caption = 'Approved Date Time'; }
                field(blNo; Rec."BL No.") { Caption = 'BL No.'; }
                field(clearingAgent; Rec."Clearing Agent") { Caption = 'Clearing Agent'; }
                field(clearingAgentName; Rec."Clearing Agent Name") { Caption = 'Clearing Agent Name'; }
                field(consigneeName; Rec."Consignee Name") { Caption = 'Consignee Name'; }
                field(consigneeNo; Rec."Consignee No.") { Caption = 'Consignee No.'; }
                field(containerChasisNo; Rec."Container /Chasis No.") { Caption = 'Container /Chasis No.'; }
                field(expiredDate; Rec."Expired Date") { Caption = 'Expired Date'; }
                field(gatePassPrinted; Rec."Gate Pass Printed") { Caption = 'Gate Pass Printed'; }
                field(gatePassStatus; Rec."Gate Pass Status") { Caption = 'Gate Pass Status'; }
                field(globalDimension1Code; Rec."Global Dimension 1 Code") { Caption = 'Global Dimension 1 Code'; }
                field(globalDimension2Code; Rec."Global Dimension 2 Code") { Caption = 'Global Dimension 2 Code'; }
                field(invoiceDate; Rec."Invoice Date") { Caption = 'Invoice Date'; }
                field(invoiceNo; Rec."Invoice No.") { Caption = 'Invoice No.'; }
                field(noOfBags; Rec."No. Of Bags") { Caption = 'No. Of Bags'; }
                field(positionID; Rec."Position ID") { Caption = 'Position ID'; }
                field(receiptNo; Rec."Receipt No.") { Caption = 'Receipt No.'; }
                field(receiptsVerified; Rec."Receipts Verified") { Caption = 'Receipts Verified'; }
                field(shippingLineConfirmed; Rec."Shipping Line Confirmed") { Caption = 'Shipping Line Confirmed'; }
                field(shortcutDimension6Code; Rec."Shortcut Dimension 6 Code") { Caption = 'Shortcut Dimension 6 Code'; }
                field(strippedUnits; Rec."Stripped Units") { Caption = 'Stripped Units'; }
                field(trailerNo; Rec."Trailer No.") { Caption = 'Trailer No.'; }
                field(tranporterDriverName; Rec."Tranporter/Driver Name") { Caption = 'Tranporter/Driver Name'; }
                field(truckNo; Rec."Truck No.") { Caption = 'Truck No.'; }
                field(jobFileNo; Rec."Job File No.") { Caption = 'Job File No.'; }

                part(Lines; "Gatepass Line API")
                {
                    EntityName = 'GatepassLineAPI';
                    EntitySetName = 'GatepassLineAPI';
                    SubPageLink = "Gate Pass No." = field("Gate Pass No.");
                }
            }
        }
    }
}

page 55215 "Gatepass Line API"
{
    PageType = API;
    APIPublisher = 'Techbizinfotech';
    APIGroup = 'apiGroup';
    APIVersion = 'v1.0';
    Caption = 'Gatepass Line API';
    EntityName = 'GatepassLineAPI';
    EntitySetName = 'GatepassLineAPI';
    SourceTable = "Gate Pass Out Line";
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {

            repeater(Lines)
            {
                field(systemId; Rec.SystemId) { Editable = false; }
                field(gatePassNo; Rec."Gate Pass No.") { Caption = 'Gate Pass No.'; }

                field(invoiceNo; Rec."Invoice No.")
                {
                    Caption = 'Invoice No.';
                }
                field(invoiceDate; Rec."Invoice Date")
                {
                    Caption = 'Invoice Date';
                }
                field(deliveryOrderNo; Rec."Delivery Order No.")
                {
                    Caption = 'Delivery Order No.';
                }
                field(containerChasisNo; Rec."Container /Chasis No.")
                {
                    Caption = 'Container /Chasis No.';
                }
                field(doNoExpiryDate; Rec."DO No. Expiry date")
                {
                    Caption = 'DO No. Expiry Date';
                }
                field(gatePassStatus; Rec."Gate Pass Status")
                {
                    Caption = 'Gate Pass Status';
                }
                field(jobFileNo; Rec."Job File No")
                {
                    Caption = 'Job File No.';
                }
                field(positionID; Rec."Position ID")
                {
                    Caption = 'Position ID';
                }
                field(receiptNo; Rec."Receipt No.")
                {
                    Caption = 'Receipt No.';
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                }
                field(trailerNo; Rec."Trailer No.")
                {
                    Caption = 'Trailer No.';
                }
                field(tranporterDriverName; Rec."Tranporter/Driver Name")
                {
                    Caption = 'Tranporter/Driver Name';
                }
                field(truckNo; Rec."Truck No.")
                {
                    Caption = 'Truck No.';
                }
                field(noOfBags; Rec."No. Of Bags")
                {
                    Caption = 'No. Of Bags';
                }
                field(consigneeName; Rec."Consignee Name")
                {
                    Caption = 'Consignee Name';
                }
                field(blNo; Rec."BL No")
                {
                    Caption = 'BL No';
                }
                field(clearingAgent; Rec."Clearing Agent")
                {
                    Caption = 'Clearing Agent';
                }
                field(agentPortPass; Rec."Agent Port Pass")
                {
                    Caption = 'Agent Port Pass';
                }
                field(agentName; Rec."Agent Name")
                {
                    Caption = 'Agent Name';
                }
            }
        }
    }
}