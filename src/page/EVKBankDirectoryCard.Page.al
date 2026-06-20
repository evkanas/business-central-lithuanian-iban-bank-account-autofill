page 70101 "EVK Bank Directory Card"
{
    Caption = 'EVK Bank Directory Card', Comment = 'lt-LT="EVK banko žinyno kortelė"';
    PageType = Card;
    SourceTable = "EVK Bank Directory";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'lt-LT="Bendra"';
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
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the SWIFT code used for autofill.', Comment = 'lt-LT="Nurodo automatiškai pildomą SWIFT kodą."';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank name used for autofill.', Comment = 'lt-LT="Nurodo automatiškai pildomą banko pavadinimą."';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank address used for autofill.', Comment = 'lt-LT="Nurodo automatiškai pildomą banko adresą."';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank city used for autofill.', Comment = 'lt-LT="Nurodo automatiškai pildomą banko miestą."';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank post code used for autofill.', Comment = 'lt-LT="Nurodo automatiškai pildomą banko pašto kodą."';
                }
            }
            group(Communication)
            {
                Caption = 'Communication', Comment = 'lt-LT="Ryšiai"';
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank phone number used for autofill.', Comment = 'lt-LT="Nurodo automatiškai pildomą banko telefono numerį."';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank email address used for autofill.', Comment = 'lt-LT="Nurodo automatiškai pildomą banko el. pašto adresą."';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank website used for autofill.', Comment = 'lt-LT="Nurodo automatiškai pildomą banko svetainę."';
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank contact name used for autofill.', Comment = 'lt-LT="Nurodo automatiškai pildomą banko kontaktinį asmenį."';
                }
            }
        }
    }
}
