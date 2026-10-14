pageextension 55053 SalesOrderExt extends "Sales Order List"
{
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        // IF (UserId <> 'GROUP.AUDIT') and (UserId <> 'TECHBIZINFOTECH') and (UserId <> 'SHILLAH') then
        //     error('You are not Authorized to view this area. Please contact Group Audit');
    end;
}
