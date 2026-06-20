codeunit 70101 "EVK Bank Account Events"
{
    [EventSubscriber(ObjectType::Table, Database::"Customer Bank Account", 'OnAfterValidateEvent', 'IBAN', false, false)]
    local procedure CustomerBankAccountIBANOnAfterValidate(var Rec: Record "Customer Bank Account"; var xRec: Record "Customer Bank Account"; CurrFieldNo: Integer)
    var
        BankAccountAutofill: Codeunit "EVK Bank Account Autofill";
    begin
        BankAccountAutofill.AutofillCustomerBankAccount(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Bank Account", 'OnAfterValidateEvent', 'IBAN', false, false)]
    local procedure VendorBankAccountIBANOnAfterValidate(var Rec: Record "Vendor Bank Account"; var xRec: Record "Vendor Bank Account"; CurrFieldNo: Integer)
    var
        BankAccountAutofill: Codeunit "EVK Bank Account Autofill";
    begin
        BankAccountAutofill.AutofillVendorBankAccount(Rec);
    end;
}
