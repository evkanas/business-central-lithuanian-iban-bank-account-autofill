permissionset 70100 "EVK Bank Autofill"
{
    Assignable = true;
    Caption = 'EVK Bank Autofill', Comment = 'lt-LT="EVK banko duomenų pildymas"';
    Permissions =
        tabledata "EVK Bank Directory" = RIMD,
        table "EVK Bank Directory" = X,
        page "EVK Bank Directory List" = X,
        page "EVK Bank Directory Card" = X,
        codeunit "EVK Bank Account Autofill" = X,
        codeunit "EVK Bank Account Events" = X;
}
