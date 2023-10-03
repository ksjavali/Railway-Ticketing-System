require "application_system_test_case"

class TransactionsTest < ApplicationSystemTestCase
  setup do
    @transaction = transactions(:one)
  end

  test "visiting the index" do
    visit transactions_url
    assert_selector "h1", text: "Transactions"
  end

  test "creating a Transaction" do
    visit transactions_url
    click_on "New Transaction"

    fill_in "Address", with: @transaction.address
    fill_in "Credit number", with: @transaction.credit_number
    fill_in "Phone number", with: @transaction.phone_number
    fill_in "Ticket price", with: @transaction.ticket_price
    fill_in "Transaction number", with: @transaction.transaction_number
    click_on "Create Transaction"

    assert_text "Transaction was successfully created"
    click_on "Back"
  end

  test "updating a Transaction" do
    visit transactions_url
    click_on "Edit", match: :first

    fill_in "Address", with: @transaction.address
    fill_in "Credit number", with: @transaction.credit_number
    fill_in "Phone number", with: @transaction.phone_number
    fill_in "Ticket price", with: @transaction.ticket_price
    fill_in "Transaction number", with: @transaction.transaction_number
    click_on "Update Transaction"

    assert_text "Transaction was successfully updated"
    click_on "Back"
  end

  test "destroying a Transaction" do
    visit transactions_url
    page.accept_confirm do
      click_on "Delete", match: :first
    end

    assert_text "Transaction was successfully destroyed"
  end
end
