# EVK Solution User Guide

## 1. Overview

EVK Solution helps users complete standard **Customer Bank Account** and **Vendor Bank Account** cards in Microsoft Dynamics 365 Business Central.

When a user enters a Lithuanian IBAN beginning with `LT`, the extension reads positions 5–9 as the five-digit bank code. It then searches **EVK Bank Directory** for that code and uses the configured record to fill the bank account details.

## 2. Required setup

Before using autofill, configure the banks that your organization works with.

1. In Business Central, select the **Search** icon or press **Alt+Q**.
2. Search for **EVK Bank Directory**.
3. Open the page and create a record for each bank code that you want the extension to recognize.

Complete these fields on each bank directory record:

- **Code** – a unique identifier for the directory record.
- **Bank Branch No.** – the five-digit bank code found in positions 5–9 of a Lithuanian IBAN. This value must be unique in the directory.
- **SWIFT Code** – the bank's SWIFT/BIC reference.
- **Name** – the bank name to copy to bank account cards.
- **Address** – the bank address to copy to bank account cards.
- **City** – the bank city.
- **Post Code** – the bank postal code.

The following fields are optional:

- **Phone No.**
- **Email**
- **Home Page**
- **Contact Name**

Optional values are copied to the corresponding bank account fields when supplied.

## 3. Example bank directory setup

The following example is fictional and intended only for testing:

| Field | Sample value |
|---|---|
| Code | `SAMPLE` |
| Bank Branch No. | `00000` |
| SWIFT Code | `EXAMPLE0XXX` |
| Name | `Example Bank` |
| Address | `1 Sample Street` |
| City | `Example City` |
| Post Code | `LT-00000` |
| Phone No. | Leave blank |
| Email | `bank@example.invalid` |
| Home Page | `https://example.invalid/` |
| Contact Name | Leave blank |

An IBAN-shaped value such as `LT000000000000000000` contains the sample bank code `00000` in positions 5–9. It is deliberately fictional and must not be used as a real bank account number.

Always verify real bank codes, SWIFT codes, addresses, and contact information with reliable current sources before using the directory in production.

## 4. Customer bank account usage

1. Search for and open **Customers**.
2. Open the required customer card.
3. Choose the **Bank Accounts** action.
4. Open an existing Customer Bank Account card or create a new one.
5. Enter a Lithuanian IBAN in the **IBAN** field and leave the field to validate it.

If positions 5–9 match **Bank Branch No.** in EVK Bank Directory, the extension fills the configured bank details automatically.

If the bank account **Code** is empty, the extension may generate it from the bank code. If the generated code is already used for that customer, the extension finds the next available value. An existing Code is not overwritten.

Review the populated values before closing the card.

## 5. Vendor bank account usage

1. Search for and open **Vendors**.
2. Open the required vendor card.
3. Choose the **Bank Accounts** action.
4. Open an existing Vendor Bank Account card or create a new one.
5. Enter a Lithuanian IBAN in the **IBAN** field and leave the field to validate it.

If the bank code exists in EVK Bank Directory, the configured bank details are filled automatically. When Code is empty, the extension may generate it from the bank code. A Code that already contains a value is not overwritten.

Review the populated values before closing the card.

## 6. When the bank code is not found

The extension does not raise an error when the five-digit bank code is absent from EVK Bank Directory. Only safe values derived from the entered IBAN are filled where applicable, such as the bank branch number and bank account number.

To configure the missing bank:

1. Open **EVK Bank Directory**.
2. Add a record whose **Bank Branch No.** matches positions 5–9 of the IBAN.
3. Return to the Customer Bank Account or Vendor Bank Account card.
4. Re-enter or revalidate the IBAN.

The extension then attempts the directory lookup again.

## 7. Limitations

- The extension supports autofill and does not replace full IBAN or banking compliance validation.
- It does not guarantee that information stored in EVK Bank Directory is accurate or current.
- It is a portfolio/sample extension.
- Production use requires verification of bank reference data, user permissions, security requirements, and organization-specific business rules.

## 8. Manual testing

Use fictional data in a Business Central sandbox:

1. Open **EVK Bank Directory** and create the sample record from this guide with bank code `00000`.
2. Open a Customer Bank Account card.
3. Leave **Code** empty and enter `LT000000000000000000` in **IBAN**.
4. Leave the IBAN field and confirm that Code, Bank Branch No., Bank Account No., and the configured directory fields are filled.
5. Repeat the test on a Vendor Bank Account card.
6. Enter an LT-prefixed, IBAN-shaped test value containing a five-digit bank code that is not in the directory. Confirm that no error is raised and only applicable IBAN-derived fields are filled.
7. Populate **Code** manually, enter or revalidate the IBAN, and confirm that the existing Code is not overwritten.

The sample value demonstrates field extraction only. It is not a checksum-valid or usable IBAN.
