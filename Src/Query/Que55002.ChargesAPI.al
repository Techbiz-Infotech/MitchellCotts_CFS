Page 55209 "Charges API"
{
    PageType = API;
    APIGroup = 'apiGroup';
    APIPublisher = 'Techbizinfotech';
    APIVersion = 'v1.0';
    EntityName = 'ChargesAPI';
    EntitySetName = 'ChargesAPI';
    DelayedInsert = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    SourceTable = "Charge ID Group Header";
    ODataKeyFields = SystemId;



    Layout
    {
        area(content)
        {
            field(baseOn; Rec."Base On")
            {
                Caption = 'Base On';
            }
            field(calculationType; Rec."Calculation Type")
            {
                Caption = 'Calculation Type';
            }
            field(chargeDescription; Rec."Charge Description")
            {
                Caption = 'Charge Description';
            }
            field(chargeIDGroupCode; Rec."Charge ID Group Code")
            {
                Caption = 'Charge ID Group Code';
            }
            field(chargeType; Rec."Charge Type")
            {
                Caption = 'Charge Type';
            }
            field(firstBracket; Rec."First Bracket")
            {
                Caption = 'First Bracket';
            }
            field(freeDays; Rec."Free Days")
            {
                Caption = 'Free Days';
            }
            field(henceForth; Rec.HenceForth)
            {
                Caption = 'HenceForth';
            }
            field(includeReceivedDay; Rec."Include Received Day")
            {
                Caption = 'Include Received Day';
            }
            field(secondBracket; Rec."Second Bracket")
            {
                Caption = 'Second Bracket';
            }
            field(startAfter; Rec."Start After")
            {
                Caption = 'Start After';
            }
            field(status; Rec.Status)
            {
                Caption = 'Status';
            }
            field(SystemId; Rec.SystemId) { }

            part(Lines; "Charge Line API")
            {
                EntityName = 'lines';
                EntitySetName = 'lines';

                SubPageLink = "Charge ID Group Code" = field("Charge ID Group Code");

            }
        }
    }
}
page 55210 "Charge Line API"
{
    PageType = API;
    DelayedInsert = true;
    APIPublisher = 'Techbizinfotech';
    APIGroup = 'apiGroup';
    APIVersion = 'v1.0';
    Caption = 'Charge Line API';
    EntityName = 'lines';
    EntitySetName = 'lines';
    ODataKeyFields = SystemId;

    SourceTable = "Charge ID Group Line";

    layout
    {
        area(content)
        {
            field(activeInActive; Rec."Active/In-Active")
            {
                Caption = 'Active/In-Active';
            }
            field(charge; Rec.Charge)
            {
                Caption = 'Charge';
            }
            field(calculateIfStorageDays; Rec."Calculate if Storage Days")
            {
                Caption = 'Calculate if Storage Days';
            }
            field(chargeCategory; Rec."Charge Category")
            {
                Caption = 'Charge Category';
            }
            field(chargeDescription; Rec."Charge Description ")
            {
                Caption = 'Charge Description';
            }
            field(chargeIDGroupCode; Rec."Charge ID Group Code")
            {
                Caption = 'Charge ID Group Code';
            }
            field(firstInterval; Rec."First Interval")
            {
                Caption = 'First Interval';
            }
            field(freeDays; Rec."Free Days")
            {
                Caption = 'Free Days';
            }
            field(henceForth; Rec.HenceForth)
            {
                Caption = 'Hence Forth';
            }
            field(lineNo; Rec."Line No.")
            {
                Caption = 'Line No.';
            }
            field(relyOnStorage; Rec."Rely On Storage")
            {
                Caption = 'Rely On Storage';
            }
            field(secondInterval; Rec."Second Interval")
            {
                Caption = 'Second Interval';
            }
            field(thirdInterval; Rec."Third Interval")
            {
                Caption = 'Third Interval';
            }


            field(SystemId; Rec.SystemId) { }
        }
    }
}