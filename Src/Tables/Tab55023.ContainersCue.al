table 55023 "Containers Cue"
{
    Caption = 'Containers Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Received Containers Today"; Integer)
        {
            Caption = 'Received Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER')));
        }
        field(3; "Released Containers Today"; Integer)
        {
            Caption = 'Released Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER')));
        }
        field(4; "Stock 40FT"; Integer)
        {
            Caption = 'Stock 40FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('40FT')));
        }
        field(5; "Stock 20FT"; Integer)
        {
            Caption = 'Stock 20FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT')));
        }
        field(6; "Current Date Filter"; Date)
        {
            Caption = 'Current Date Filter';
            FieldClass = FlowFilter;
        }
        field(7; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(8; "Received Units Today"; Integer)
        {
            Caption = 'Received Units Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('UNIT')));
        }
        field(9; "Released Units Today"; Integer)
        {
            Caption = 'Released Units Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('UNIT')));
        }
        field(10; "Stock 1.5MT"; Integer)
        {
            Caption = 'Stock 1.5MT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('1.5MT')));
        }
        field(11; "Stock 2.0MT"; Integer)
        {
            Caption = 'Stock 2.0MT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('2.0MT')));
        }
        field(12; "Stock 5.0MT"; Integer)
        {
            Caption = 'Stock 5.0MT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('5.0MT')));
        }
        field(13; "Stock 10MT"; Integer)
        {
            Caption = 'Stock 10MT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('10MT')));
        }
        field(14; "Stock OVER 10MT"; Integer)
        {
            Caption = 'Stock OVER 10MT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('OVER 10MT')));
        }
        field(15; "Received Loose Today"; Integer)
        {
            Caption = 'Received Loose Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('LOOSE')));
        }
        field(16; "Released Loose Today"; Integer)
        {
            Caption = 'Released Loose Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('LOOSE')));
        }
        field(17; "Stock Loose"; Integer)
        {
            Caption = 'Stock Loose';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 4 Code" = filter('LOOSE')));
        }
        field(18; "Container Stock"; Integer)
        {
            Caption = 'Container Stock';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT|40FT')));
        }
        field(19; "EMPTYCTR Rcvd Containers Today"; Integer)
        {
            Caption = 'Received Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 6 Code" = filter('EMPTY')));
        }
        field(20; "EMPTYCTR Reld Containers Today"; Integer)
        {
            Caption = 'Released Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 6 Code" = filter('EMPTY')));
        }
        field(21; "EMPTYCTR Stock 40FT"; Integer)
        {
            Caption = 'Stock 40FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('40FT'), "Shortcut Dimension 6 Code" = filter('EMPTY')));
        }
        field(22; "EMPTYCTR Stock 20FT"; Integer)
        {
            Caption = 'Stock 20FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT'), "Shortcut Dimension 6 Code" = filter('EMPTY')));
        }
        field(23; "EMPTYCTR Container Stock"; Integer)
        {
            Caption = 'Container Stock';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT|40FT'), "Shortcut Dimension 6 Code" = filter('EMPTY')));
        }
        field(24; "EXPORT Rcvd Containers Today"; Integer)
        {
            Caption = 'Received Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code" = filter('EXPORT')));
        }
        field(25; "EXPORT Reld Containers Today"; Integer)
        {
            Caption = 'Released Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code" = filter('EXPORT')));
        }
        field(26; "EXPORT Stock 40FT"; Integer)
        {
            Caption = 'Stock 40FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('40FT'), "Shortcut Dimension 6 Code" = filter('EXPORT')));
        }
        field(27; "EXPORT Stock 20FT"; Integer)
        {
            Caption = 'Stock 20FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT'), "Shortcut Dimension 6 Code" = filter('EXPORT')));
        }
        field(28; "EXPORT Container Stock"; Integer)
        {
            Caption = 'Container Stock';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT|40FT'), "Shortcut Dimension 6 Code" = filter('EXPORT')));
        }
        field(29; "IMPORT Rcvd Containers Today"; Integer)
        {
            Caption = 'Received Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code" = filter('IMPORT')));
        }
        field(30; "IMPORT Reld Containers Today"; Integer)
        {
            Caption = 'Released Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code" = filter('IMPORT')));
        }
        field(31; "IMPORT Stock 40FT"; Integer)
        {
            Caption = 'Stock 40FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('40FT'), "Shortcut Dimension 6 Code" = filter('IMPORT')));
        }
        field(32; "IMPORT Stock 20FT"; Integer)
        {
            Caption = 'Stock 20FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT'), "Shortcut Dimension 6 Code" = filter('IMPORT')));
        }
        field(33; "IMPORT Container Stock"; Integer)
        {
            Caption = 'Container Stock';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT|40FT'), "Shortcut Dimension 6 Code" = filter('IMPORT')));
        }
        //overland export
        field(34; "OVER EX Rcvd Containers Today"; Integer)
        {
            Caption = 'Received Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code" = filter('OVERLAND EXPORT')));
        }
        field(35; "OVER EX Reld Containers Today"; Integer)
        {
            Caption = 'Released Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code" = filter('OVERLAND EXPORT')));
        }
        field(36; "OVERLAND EX Stock 40FT"; Integer)
        {
            Caption = 'Stock 40FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('40FT'), "Shortcut Dimension 6 Code" = filter('OVERLAND EXPORT')));
        }
        field(37; "OVERLAND EXP Stock 20FT"; Integer)
        {
            Caption = 'Stock 20FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT'), "Shortcut Dimension 6 Code" = filter('OVERLAND EXPORT')));
        }
        field(38; "OVERLAND EXP Container Stock"; Integer)
        {
            Caption = 'Container Stock';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT|40FT'), "Shortcut Dimension 6 Code" = filter('OVERLAND EXPORT')));
        }
        //overland end
        field(39; "TRANSHIP Rcvd Containers Today"; Integer)
        {
            Caption = 'Received Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code" = filter('TRANSHIPMENT')));
        }
        field(40; "TRANSHIP Reld Containers Today"; Integer)
        {
            Caption = 'Released Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code" = filter('TRANSHIPMENT')));
        }
        field(41; "TRANSHIPMENT Stock 40FT"; Integer)
        {
            Caption = 'Stock 40FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('40FT'), "Shortcut Dimension 6 Code" = filter('TRANSHIPMENT')));
        }
        field(42; "TRANSHIPMENT Stock 20FT"; Integer)
        {
            Caption = 'Stock 20FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT'), "Shortcut Dimension 6 Code" = filter('TRANSHIPMENT')));
        }
        field(43; "TRANSHIPMENT Container Stock"; Integer)
        {
            Caption = 'Container Stock';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT|40FT'), "Shortcut Dimension 6 Code" = filter('TRANSHIPMENT')));
        }
        //overland TRA
        field(44; "OVER TRA Rcvd Containers Today"; Integer)
        {
            Caption = 'Received Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code" = filter('OVERLAND - TRA')));
        }
        field(45; "OVER TRA Reld Containers Today"; Integer)
        {
            Caption = 'Released Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code" = filter('OVERLAND - TRA')));
        }
        field(46; "OVERLAND TRA Stock 40FT"; Integer)
        {
            Caption = 'Stock 40FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('40FT'), "Shortcut Dimension 6 Code" = filter('OVERLAND - TRA')));
        }
        field(47; "OVERLAND TRA Stock 20FT"; Integer)
        {
            Caption = 'Stock 20FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT'), "Shortcut Dimension 6 Code" = filter('OVERLAND - TRA')));
        }
        field(48; "OVERLAND TRA Container Stock"; Integer)
        {
            Caption = 'Container Stock';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT|40FT'), "Shortcut Dimension 6 Code" = filter('OVERLAND - TRA')));
        }
        //overland URA
        field(49; "OVER URA Rcvd Containers Today"; Integer)
        {
            Caption = 'Received Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code" = filter('OVERLAND - URA')));
        }
        field(50; "OVER URA Reld Containers Today"; Integer)
        {
            Caption = 'Released Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code" = filter('OVERLAND - URA')));
        }
        field(51; "OVERLAND URA Stock 40FT"; Integer)
        {
            Caption = 'Stock 40FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('40FT'), "Shortcut Dimension 6 Code" = filter('OVERLAND - URA')));
        }
        field(52; "OVERLAND URA Stock 20FT"; Integer)
        {
            Caption = 'Stock 20FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT'), "Shortcut Dimension 6 Code" = filter('OVERLAND - URA')));
        }
        field(53; "OVERLAND URA Container Stock"; Integer)
        {
            Caption = 'Container Stock';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT|40FT'), "Shortcut Dimension 6 Code" = filter('OVERLAND - URA')));
        }
        //cnt
        //  field(54; "Rcvd Containers Today"; Integer)
        // {
        //     Caption = 'Received Containers Today';
        //     FieldClass = FlowField;
        //     CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code"=filter(<>'EMPTY')));
        // }
        // field(55; "Reld Containers Today"; Integer)
        // {
        //     Caption = 'Released Containers Today';
        //     FieldClass = FlowField;
        //     CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('CONTAINER'), "Shortcut Dimension 6 Code"=filter(<>'EMPTY')));
        // }
        // field(56; "cnt Stock 40FT"; Integer)
        // {
        //     Caption = 'Stock 40FT';
        //     FieldClass = FlowField;
        //     CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('40FT'),"Shortcut Dimension 6 Code"=filter(<>'EMPTY')));
        // }
        // field(57; "cnt Stock 20FT"; Integer)
        // {
        //     Caption = 'Stock 20FT';
        //     FieldClass = FlowField;
        //     CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT'),"Shortcut Dimension 6 Code"=filter(<>'EMPTY') ));
        // }
        // field(58; "cnt Container Stock"; Integer)
        // {
        //     Caption = 'Container Stock';
        //     FieldClass = FlowField;
        //     CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT|40FT'), "Shortcut Dimension 6 Code"=filter(<>'EMPTY')));
        // }
        //end of cnt
        //ISOTANKS
        field(59; "ISO Rcvd Containers Today"; Integer)
        {
            Caption = 'Received Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('ISOTANK')));
        }
        field(60; "ISO Reld Containers Today"; Integer)
        {
            Caption = 'Released Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('ISOTANK')));
        }
        field(61; "ISO Stock 40FT"; Integer)
        {
            Caption = 'Stock 40FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('40FT'), "Shortcut Dimension 4 Code" = filter('ISOTANK')));
        }
        field(62; "ISO cnt Stock 20FT"; Integer)
        {
            Caption = 'Stock 20FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT'), "Shortcut Dimension 4 Code" = filter('ISOTANK')));
        }
        field(63; " ISO cnt Container Stock"; Integer)
        {
            Caption = 'Container Stock';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT|40FT'), "Shortcut Dimension 4 Code" = filter('ISOTANK')));
        }
        //End of Isotanks
        //empty
        field(64; "Empty Rcvd Containers Today"; Integer)
        {
            Caption = 'Received Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('EMPTY - REJECTED' | 'EMPTY CONTAINER' | 'EXPORT-WORTHY' | 'NON-SERVICEABLE')));
        }
        field(65; "Empty Reld Containers Today"; Integer)
        {
            Caption = 'Released Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('EMPTY - REJECTED' | 'EMPTY CONTAINER' | 'EXPORT-WORTHY' | 'NON-SERVICEABLE')));
        }
        field(66; "Empty Stock 40FT"; Integer)
        {
            Caption = 'Stock 40FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('40FT'), "Shortcut Dimension 4 Code" = filter('EMPTY - REJECTED' | 'EMPTY CONTAINER' | 'EXPORT-WORTHY' | 'NON-SERVICEABLE')));
        }
        field(67; "Empty cnt Stock 20FT"; Integer)
        {
            Caption = 'Stock 20FT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT'), "Shortcut Dimension 4 Code" = filter('EMPTY - REJECTED' | 'EMPTY CONTAINER' | 'EXPORT-WORTHY' | 'NON-SERVICEABLE')));
        }
        field(68; " Empty cnt Container Stock"; Integer)
        {
            Caption = 'Container Stock';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('20FT|40FT'), "Shortcut Dimension 4 Code" = filter('EMPTY - REJECTED' | 'EMPTY CONTAINER' | 'EXPORT-WORTHY' | 'NON-SERVICEABLE')));
        }
        //end of all empty
        //stripped
        field(69; "Stripped Rcvd Containers Today"; Integer)
        {
            Caption = 'Received Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 5 Code" = filter('LOOSE'), "Shortcut Dimension 4 Code" = filter('STRIPPED PACKAGE')));
        }
        field(70; "Stripped Reld Containers Today"; Integer)
        {
            Caption = 'Released Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 5 Code" = filter('LOOSE'), "Shortcut Dimension 4 Code" = filter('STRIPPED PACKAGE')));
        }

        field(73; " Stripped cnt Container Stock"; Integer)
        {
            Caption = 'Container Stock';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('LOOSE'), "Shortcut Dimension 4 Code" = filter('STRIPPED PACKAGE')));
        }
        //stripped end
        //stripped unit
        field(74; "Stripped_Unit Rcvd Cont Today"; Integer)
        {
            Caption = 'Empty Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), "Date Received" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('STRIPPED UNIT')));
        }
        field(75; "Stripped_Unit Reld Cont Today"; Integer)
        {
            Caption = 'Released Containers Today';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Released = filter(true), "Date Released" = Field("Current Date Filter"), "Shortcut Dimension 4 Code" = filter('STRIPPED UNIT')));
        }
        field(76; "Stripped_Unit Stock 1.5MT"; Integer)
        {
            Caption = 'Stock 1.5MT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('40FT'), "Shortcut Dimension 4 Code" = filter('STRIPPED UNIT')));
        }
        field(77; "Stripped_Unit cnt Stock 2.0MT"; Integer)
        {
            Caption = 'Stock 2.0MT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('2.0MT'), "Shortcut Dimension 4 Code" = filter('STRIPPED UNIT')));
        }
        field(78; "Stripped_Unit Stock 5.0MT"; Integer)
        {
            Caption = 'Stock 5.0MT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('5.0MT'), "Shortcut Dimension 4 Code" = filter('STRIPPED UNIT')));
        }
        field(79; "Stripped_Unit 10MT"; Integer)
        {
            Caption = 'Stock 10MT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('10MT'), "Shortcut Dimension 4 Code" = filter('STRIPPED UNIT')));
        }
        field(80; "Stripped_Unit Stock OVER 10MT"; Integer)
        {
            Caption = 'Stock OVER 10MT';
            FieldClass = FlowField;
            CalcFormula = count("Manifest Line" where(Received = filter(true), Released = filter(false), "Shortcut Dimension 5 Code" = filter('OVER 10MT'), "Shortcut Dimension 4 Code" = filter('STRIPPED UNIT')));
        }


        //stripped unit end
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
