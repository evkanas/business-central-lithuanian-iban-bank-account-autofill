table 70100 "EVK Bank Directory"
{
    Caption = 'EVK Bank Directory', Comment = 'lt-LT="EVK bankų žinynas"';
    DataClassification = OrganizationIdentifiableInformation;
    DrillDownPageId = "EVK Bank Directory List";
    LookupPageId = "EVK Bank Directory List";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code', Comment = 'lt-LT="Kodas"';
            NotBlank = true;
        }
        field(2; "Bank Branch No."; Code[20])
        {
            Caption = 'Bank Branch No.', Comment = 'lt-LT="Banko skyriaus kodas"';
            NotBlank = true;
        }
        field(3; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code', Comment = 'lt-LT="SWIFT kodas"';
        }
        field(4; Name; Text[100])
        {
            Caption = 'Name', Comment = 'lt-LT="Pavadinimas"';
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address', Comment = 'lt-LT="Adresas"';
        }
        field(6; City; Text[30])
        {
            Caption = 'City', Comment = 'lt-LT="Miestas"';
        }
        field(7; "Post Code"; Code[20])
        {
            Caption = 'Post Code', Comment = 'lt-LT="Pašto kodas"';
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.', Comment = 'lt-LT="Telefono nr."';
            ExtendedDatatype = PhoneNo;
        }
        field(9; "E-Mail"; Text[80])
        {
            Caption = 'Email', Comment = 'lt-LT="El. paštas"';
            ExtendedDatatype = EMail;
        }
        field(10; "Home Page"; Text[80])
        {
            Caption = 'Home Page', Comment = 'lt-LT="Svetainė"';
            ExtendedDatatype = URL;
        }
        field(11; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name', Comment = 'lt-LT="Kontaktinis asmuo"';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
        key(BankBranchNo; "Bank Branch No.")
        {
            Unique = true;
        }
    }
}
