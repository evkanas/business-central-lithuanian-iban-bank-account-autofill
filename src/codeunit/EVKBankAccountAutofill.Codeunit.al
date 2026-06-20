codeunit 70100 "EVK Bank Account Autofill"
{
    procedure AutofillCustomerBankAccount(var CustomerBankAccount: Record "Customer Bank Account")
    var
        BankDirectory: Record "EVK Bank Directory";
        BankCode: Code[20];
    begin
        CustomerBankAccount.Validate(
            "Bank Account No.",
            CopyStr(CustomerBankAccount.IBAN, 1, MaxStrLen(CustomerBankAccount."Bank Account No.")));

        if not TryGetLithuanianBankCode(CustomerBankAccount.IBAN, BankCode) then
            exit;

        EnsureCustomerBankAccountCode(CustomerBankAccount, BankCode);
        CustomerBankAccount.Validate(
            "Bank Branch No.",
            CopyStr(BankCode, 1, MaxStrLen(CustomerBankAccount."Bank Branch No.")));

        if not FindBank(BankCode, BankDirectory) then
            exit;

        ApplyBankDirectory(CustomerBankAccount, BankDirectory);
    end;

    procedure AutofillVendorBankAccount(var VendorBankAccount: Record "Vendor Bank Account")
    var
        BankDirectory: Record "EVK Bank Directory";
        BankCode: Code[20];
    begin
        VendorBankAccount.Validate(
            "Bank Account No.",
            CopyStr(VendorBankAccount.IBAN, 1, MaxStrLen(VendorBankAccount."Bank Account No.")));

        if not TryGetLithuanianBankCode(VendorBankAccount.IBAN, BankCode) then
            exit;

        EnsureVendorBankAccountCode(VendorBankAccount, BankCode);
        VendorBankAccount.Validate(
            "Bank Branch No.",
            CopyStr(BankCode, 1, MaxStrLen(VendorBankAccount."Bank Branch No.")));

        if not FindBank(BankCode, BankDirectory) then
            exit;

        ApplyBankDirectory(VendorBankAccount, BankDirectory);
    end;

    local procedure TryGetLithuanianBankCode(IBAN: Code[50]; var BankCode: Code[20]): Boolean
    var
        CharacterIndex: Integer;
    begin
        Clear(BankCode);
        if StrLen(IBAN) < 9 then
            exit(false);
        if UpperCase(CopyStr(IBAN, 1, 2)) <> 'LT' then
            exit(false);

        BankCode := CopyStr(IBAN, 5, 5);
        for CharacterIndex := 1 to StrLen(BankCode) do
            if not (BankCode[CharacterIndex] in ['0' .. '9']) then begin
                Clear(BankCode);
                exit(false);
            end;

        exit(StrLen(BankCode) = 5);
    end;

    local procedure FindBank(BankCode: Code[20]; var BankDirectory: Record "EVK Bank Directory"): Boolean
    begin
        BankDirectory.SetRange("Bank Branch No.", BankCode);
        exit(BankDirectory.FindFirst());
    end;

    local procedure EnsureCustomerBankAccountCode(var CustomerBankAccount: Record "Customer Bank Account"; BankCode: Code[20])
    var
        ExistingBankAccount: Record "Customer Bank Account";
        CandidateCode: Code[20];
    begin
        if CustomerBankAccount.Code <> '' then
            exit;

        CandidateCode := CopyStr(BankCode, 1, MaxStrLen(CandidateCode));
        ExistingBankAccount.SetRange("Customer No.", CustomerBankAccount."Customer No.");
        ExistingBankAccount.SetRange(Code, CandidateCode);
        while ExistingBankAccount.FindFirst() do begin
            CandidateCode := IncStr(CandidateCode);
            ExistingBankAccount.SetRange(Code, CandidateCode);
        end;
        CustomerBankAccount.Validate(Code, CandidateCode);
    end;

    local procedure EnsureVendorBankAccountCode(var VendorBankAccount: Record "Vendor Bank Account"; BankCode: Code[20])
    var
        ExistingBankAccount: Record "Vendor Bank Account";
        CandidateCode: Code[20];
    begin
        if VendorBankAccount.Code <> '' then
            exit;

        CandidateCode := CopyStr(BankCode, 1, MaxStrLen(CandidateCode));
        ExistingBankAccount.SetRange("Vendor No.", VendorBankAccount."Vendor No.");
        ExistingBankAccount.SetRange(Code, CandidateCode);
        while ExistingBankAccount.FindFirst() do begin
            CandidateCode := IncStr(CandidateCode);
            ExistingBankAccount.SetRange(Code, CandidateCode);
        end;
        VendorBankAccount.Validate(Code, CandidateCode);
    end;

    local procedure ApplyBankDirectory(var CustomerBankAccount: Record "Customer Bank Account"; BankDirectory: Record "EVK Bank Directory")
    begin
        CustomerBankAccount.Validate(Name, CopyStr(BankDirectory.Name, 1, MaxStrLen(CustomerBankAccount.Name)));
        CustomerBankAccount.Validate(Address, CopyStr(BankDirectory.Address, 1, MaxStrLen(CustomerBankAccount.Address)));
        CustomerBankAccount.Validate(City, CopyStr(BankDirectory.City, 1, MaxStrLen(CustomerBankAccount.City)));
        CustomerBankAccount.Validate("Post Code", CopyStr(BankDirectory."Post Code", 1, MaxStrLen(CustomerBankAccount."Post Code")));
        CustomerBankAccount.Validate("SWIFT Code", CopyStr(BankDirectory."SWIFT Code", 1, MaxStrLen(CustomerBankAccount."SWIFT Code")));
        CustomerBankAccount.Validate("Phone No.", CopyStr(BankDirectory."Phone No.", 1, MaxStrLen(CustomerBankAccount."Phone No.")));
        CustomerBankAccount.Validate("E-Mail", CopyStr(BankDirectory."E-Mail", 1, MaxStrLen(CustomerBankAccount."E-Mail")));
        CustomerBankAccount.Validate("Home Page", CopyStr(BankDirectory."Home Page", 1, MaxStrLen(CustomerBankAccount."Home Page")));
        CustomerBankAccount.Validate(Contact, CopyStr(BankDirectory."Contact Name", 1, MaxStrLen(CustomerBankAccount.Contact)));
    end;

    local procedure ApplyBankDirectory(var VendorBankAccount: Record "Vendor Bank Account"; BankDirectory: Record "EVK Bank Directory")
    begin
        VendorBankAccount.Validate(Name, CopyStr(BankDirectory.Name, 1, MaxStrLen(VendorBankAccount.Name)));
        VendorBankAccount.Validate(Address, CopyStr(BankDirectory.Address, 1, MaxStrLen(VendorBankAccount.Address)));
        VendorBankAccount.Validate(City, CopyStr(BankDirectory.City, 1, MaxStrLen(VendorBankAccount.City)));
        VendorBankAccount.Validate("Post Code", CopyStr(BankDirectory."Post Code", 1, MaxStrLen(VendorBankAccount."Post Code")));
        VendorBankAccount.Validate("SWIFT Code", CopyStr(BankDirectory."SWIFT Code", 1, MaxStrLen(VendorBankAccount."SWIFT Code")));
        VendorBankAccount.Validate("Phone No.", CopyStr(BankDirectory."Phone No.", 1, MaxStrLen(VendorBankAccount."Phone No.")));
        VendorBankAccount.Validate("E-Mail", CopyStr(BankDirectory."E-Mail", 1, MaxStrLen(VendorBankAccount."E-Mail")));
        VendorBankAccount.Validate("Home Page", CopyStr(BankDirectory."Home Page", 1, MaxStrLen(VendorBankAccount."Home Page")));
        VendorBankAccount.Validate(Contact, CopyStr(BankDirectory."Contact Name", 1, MaxStrLen(VendorBankAccount.Contact)));
    end;
}
