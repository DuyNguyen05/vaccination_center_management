class ExportBillService
  include User::DetailInjectionBookHelper

  attr_reader :pdf_options

  def initialize options
    @pdf_options = {
      page_size: "A4",
      margin: {top: 0, bottom: 0, left: 0, right: 0},
      encoding: "UTF-8",
      layout: "pdf",
      progress: proc { |output| puts output }
    }
    @options = options
  end

  def create_document
    build_pdf_document
  end

  private

  def build_pdf_document
    merged_document = CombinePDF.new
    # rubocop:disable Rails/OutputSafety
    predesigned_html = Template.last.content.html_safe
    # rubocop:enable Rails/OutputSafety
    number_injections = number_injections @options[:bill].detail_injection_book
    amount = amount @options[:bill].detail_injection_book
    total_price = total_price @options[:bill].detail_injection_book
    doctor_name = @options[:bill].doctor.details_info.full_name
    nurse_name = @options[:bill]&.nurse&.details_info&.full_name
    cashier_name = @options[:bill]&.cashier&.details_info&.full_name
    paymenter_name = @options[:bill]&.detail_injection_book&.injection_book&.info_injection_book&.guardian_name

    filled_in_template = predesigned_html.sub "{{vaccination_center_address}}", @options[:vaccination_center].address.to_s
    filled_in_template.sub! "{{number_phone}}", @options[:vaccination_center].number_phone.to_s
    filled_in_template.sub! "{{time_now}}", Time.now.strftime("%Hh:%Mm, Ngày %d tháng %m năm %Y ").to_s
    filled_in_template.sub! "{{bill_code}}", @options[:bill].code.to_s
    filled_in_template.sub! "{{injection_book_name}}", @options[:bill].detail_injection_book.injection_book.name_person_injected
    filled_in_template.sub! "{{current_address}}",  @options[:bill].detail_injection_book.injection_book.info_injection_book.addresses&.first&.current_address.to_s
    filled_in_template.sub! "{{date_of_birth}}", @options[:bill].detail_injection_book.injection_book.date_of_birth.strftime("%d/%m/%Y ").to_s
    filled_in_template.sub! "{{gender}}", @options[:bill].detail_injection_book.injection_book.gender.to_s
    filled_in_template.sub! "{{number_phone_injection_book}}", @options[:bill].detail_injection_book.injection_book.info_injection_book.number_phone.to_s
    filled_in_template.sub! "{{detail_injection_book}}", load_detail_bill
    filled_in_template.sub! "{{number_injections}}", number_injections.to_s
    filled_in_template.sub! "{{amount}}", amount.to_s
    filled_in_template.sub! "{{total_price}}", total_price.to_s
    filled_in_template.sub! "{{doctor_name}}", doctor_name.to_s
    filled_in_template.sub! "{{nurse_name}}", nurse_name.to_s
    filled_in_template.sub! "{{cashier_name}}", cashier_name.to_s
    filled_in_template.sub! "{{paymenter_name}}", paymenter_name.to_s

    pdf = WickedPdf.new.pdf_from_string(filled_in_template, pdf_options)
    merged_document << CombinePDF.parse(pdf)

    file_name = create_document_identifier
    output_file = build_file_path(file_name)
    merged_document.save output_file

    "#{ENV['EXPORT_FOLDER']}#{file_name}"
  end

  def load_detail_bill
    detail_injection_book = ""

    @options[:bill].detail_bills.each do |detail_bill|
      vaccine_name = detail_bill.vaccine.name
      vaccine_dosage = detail_bill.vaccine.dosage
      vaccine_unit = detail_bill.vaccine.unit
      number_injection = detail_bill.number_injection
      expiry_date = detail_bill.vaccine.expiry_date.strftime("%d/%m/%Y ")
      saleprice = number_with_delimiter(detail_bill.vaccine.saleprice)
      amount_price = number_with_delimiter((detail_bill.number_injection)*(detail_bill.vaccine.saleprice.to_i))

      detail_injection_book << "<tr><td>#{vaccine_name}</td><td>#{vaccine_dosage}/#{vaccine_unit}
                                </td> <td><p>#{number_injection}</p></td> <td>#{expiry_date}</td>
                                <td>#{saleprice}</td> <td>#{amount_price}</td> </tr>"
    end
    detail_injection_book
  end

  def create_document_identifier
    sanitized_name = "Phiếu thu".strip.downcase.mb_chars.normalize(:kd).tr("đĐ", "dD")
                                             .gsub(/[^\x00-\x7F]/n, "").gsub(/[^a-z0-9\s+]/, "-").gsub(/\s+/, "_").to_s
    # rubocop:disable Style/FormatStringToken
    "#{sanitized_name}_#{Time.zone.now.strftime('%Y%m%d_%H%M%S')}.pdf"
    # rubocop:enable Style/FormatStringToken
  end

  def build_file_path file_name
    if Rails.env.development?
      Dir.mkdir("#{Rails.public_path}/exports/") if Dir["#{Rails.public_path}/exports/"].blank?
      Rails.root.join("public", "exports", file_name)
    end
  end
end
