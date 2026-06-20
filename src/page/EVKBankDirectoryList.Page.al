page 70100 "EVK Bank Directory List"
{
    ApplicationArea = All;
    Caption = 'EVK Bank Directory', Comment = 'lt-LT="EVK bankų žinynas"';
    CardPageId = "EVK Bank Directory Card";
    PageType = List;
    SourceTable = "EVK Bank Directory";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Banks)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique directory entry code.', Comment = 'lt-LT="Nurodo unikalų žinyno įrašo kodą."';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the five-digit Lithuanian bank code found in positions 5 through 9 of an IBAN.', Comment = 'lt-LT="Nurodo penkių skaitmenų Lietuvos banko kodą IBAN 5–9 pozicijose."';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank name used for autofill.', Comment = 'lt-LT="Nurodo automatiškai pildomą banko pavadinimą."';
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the SWIFT code used for autofill.', Comment = 'lt-LT="Nurodo automatiškai pildomą SWIFT kodą."';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank city used for autofill.', Comment = 'lt-LT="Nurodo automatiškai pildomą banko miestą."';
                }
            }
        }
    }
}
