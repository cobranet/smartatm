require 'rest_client'
class AtmsController < ApplicationController

  def index
    session["intpay"] = {}
    url = params[:aa]
    @screen = params[:screen]
    @data = params[:data]

    if url != nil
      begin 
        @response = RestClient.get(url)
        @data = JSON.parse(@response)
      rescue RestClient::ExceptionWithResponse => e
        if e.response.code.to_s == "500" || e.response.code.to_s == "400"
          @err = JSON.parse(e.response)
        elsif e.response.code.to_s == "404" 
          @err = {}
          @err["errMessage"] = url
          @err["errCode"] = e.response.code
        end
      end
    end   
  end
  def wadl
    redirect_to "#{session[:server]}application.wadl" 
  end
  def accounts_frm
  end

  def accounts
    @url = "#{session[:server]}accounts/#{session[:tid]}/#{params[:client]}/#{params[:account_type]}"
    begin
      @response = RestClient.get(@url)
      @data = JSON.parse(@response)
    rescue RestClient::ExceptionWithResponse => e
       if e.response.code.to_s == "500" || e.response.code.to_s == "400"
          @err = JSON.parse(e.response)
        elsif e.response.code.to_s == "404" 
          @err = {}
          @err["errMessage"] = @url
          @err["errCode"] = e.response.code
       end
    end
  end
  
  def extpayresult
    @response = JSON.parse(params[:response])
  end

  
  def clientinfo_result
    url = params[:url] 
    begin
      @response = RestClient.get(url)
      @data = JSON.parse(@response)
      session[:clientId] = @data["clientId"]
    rescue RestClient::ExceptionWithResponse => e
       if e.response.code.to_s == "500" || e.response.code.to_s == "400"
          @err = JSON.parse(e.response)
        elsif e.response.code.to_s == "404" 
          @err = {}
          @err["errMessage"] = url
          @err["errCode"] = e.response.code
        end
    end
  end
  def set_accountout
    session["account"] = params["acc"]
    redirect_to reservewithfee_frm_atms_path
  end
  def set_accountin
    session["account"] = params["acc"]
    redirect_to internalpayment_frm_atms_path
  end
  def clientinfo
    @url = "#{session[:server]}clients/1/#{session[:cardnumber]}"
    redirect_to clientinfo_result_atms_path(:url => @url)
  end

  def kursna_result
    url = params[:url]
    begin
      @response = RestClient.get(url)
      @data = JSON.parse(@response)
    rescue RestClient::ExceptionWithResponse => e
       if e.response.code.to_s == "500" || e.response.code.to_s == "400"
          @err = JSON.parse(e.response)
        elsif e.response.code.to_s == "404" 
          @err = {}
          @err["errMessage"] = url
          @err["errCode"] = e.response.code
        end
    end

  end
  
  def template
    @url = "#{session[:server]}template/#{session[:tid]}/#{params[:ID]}"
    begin
      @response = RestClient.get(@url)
      @data = JSON.parse(@response)
      session["intpay"] = @data
    rescue RestClient::ExceptionWithResponse => e
       if e.response.code.to_s == "500" || e.response.code.to_s == "400"
          @err = JSON.parse(e.response)
        elsif e.response.code.to_s == "404" 
          @err = {}
          @err["errMessage"] = @url
          @err["errCode"] = e.response.code
        end
    end
  end
  
  def templates
    @url = "#{session[:server]}templates/#{session[:tid]}"
    
    begin
      @response = RestClient.get(@url)
      @data = JSON.parse(@response)

    rescue RestClient::ExceptionWithResponse => e
       if e.response.code.to_s == "500" || e.response.code.to_s == "400"
          @err = JSON.parse(e.response)
        elsif e.response.code.to_s == "404" 
          @err = {}
          @err["errMessage"] = @url
          @err["errCode"] = e.response.code
        end
    end
  end
  
  def kursna
    @url = "#{session[:server]}currencies/1/#{session[:datum]}"
    redirect_to kursna_result_atms_path(:url => @url)
  end
  
  
  def reservewithfee
    @url = "#{session[:server]}reservewithfee/1"
    data = {}
    data["sourceAccount"] = params["sourceAccount"]
    data["destinationAccount"] = params["destinationAccount"]
    data["transactionType"] = params["transactionType"]
    data["sourceCurrency"] = params["sourceCurrency"]
    data["destinationCurrency"] = params["destinationCurrency"]
    data["amount"] = params["amount"].to_f
    data["currencyDate"] = params["currencyDate"]
    data["urgency"]=params["urgency"]
    begin
      @response = RestClient.post(@url,data.to_json,:content_type => 'application/json')
    # rescue RestClient::ExceptionWithResponse => e
    #     if e.response.code.to_s == "500" || e.response.code.to_s == "400"
    #       @err = JSON.parse(e.response)
    #     elsif e.response.code.to_s == "404" 
    #       @err = {}
    #       @err["errMessage"] = url
    #       @err["errCode"] = e.response.code
    #     end
    end
    redirect_to extpayresult_atms_path(:response=>@response)
    

  end
  def internalpayment_frm
    @urnl = nil
  end
  def interpay
    @url = "#{session[:server]}internalpayments/#{session[:tid]}"
    data = {}
    data["sourceAccount"] = params["sourceAccount"]
    data["destinationAccount"] = params["destinationAccount"]
    data["transactionType"] = params["transactionType"]
    data["sourceCurrency"] = params["sourceCurrency"]
    data["destinationCurrency"] = params["destinationCurrency"]
    data["amount"] = params["amount"].to_f
    data["reservationId"] = params["reservationId"]
    data["currencyDate"] = params["currencyDate"]
    data["personalID"] = params["personalId"]
    data["actualAmount"] = params["actualAmount"]
    @response = RestClient.post(@url,data.to_json,:content_type => 'application/json')
    redirect_to extpayresult_atms_path(:response=>@response)
    
  end 
  def international_frm
    @url = nil
  #  redirect_to atms_path(:aa => @url,:screen =>'international_frm',:data => "data")
  end

  def reversal
    @url = "#{session[:server]}reversal/#{session[:tid]}/#{params[:reservationid]}"
    begin
      @response = RestClient.post(@url,nil,:content_type => 'application/json')
    rescue RestClient::ExceptionWithResponse => e
        if e.response.code.to_s == "500" || e.response.code.to_s == "400"
          @err = JSON.parse(e.response)
          raise @err
        elsif e.response.code.to_s == "404" 
          @err = {}
          @err["errMessage"] = @url
          @err["errCode"] = e.response.code
        end
    end
    redirect_to reversal_frm_atms_path
  end

  
  def reversal_frm
  end
  
  def interform
    @url = "#{session[:server]}externalpayments/1"
    data = {}
    data["sourceAccount"] = params["sourceAccount"]
    data["destinationAccount"] = params["destinationAccount"]
    data["transactionType"] = 1
    data["currency"] = params["currency"]
    data["amount"] = params["amount"].to_f
    data["reservationId"] = params["reservationId"]
    data["currencyDate"] = params["currencyDate"]
    data["personalId"] = params["personalId"]
    data["purposeCode"] = params["purposeCode"]
    data["purpose"] = params["purpose"]
    data["benRefNumber"] = params["benRefNumber"]
    data["benRefModel"] = params["benRefModel"]
    data["benName"] = params["benName"]
    data["benAddress"] = params["benAddres"]
    data["ordPartyRefModel"] = params["ordPartyRefModel"]
    data["ordPartyRefNumber"] = params["ordPartyRefNumber"]
    data["ordPartyAddress"] = params["ordPartyAddress"]
    data["urgency"]=params["urgency"]
    session["intpay"] = data

    begin
      @response = RestClient.post(@url,data.to_json,:content_type => 'application/json')
    rescue RestClient::ExceptionWithResponse => e
        if e.response.code.to_s == "500" || e.response.code.to_s == "400"
          @err = JSON.parse(e.response)
        elsif e.response.code.to_s == "404" 
          @err = {}
          @err["errMessage"] = url
          @err["errCode"] = e.response.code
        end
    end
    redirect_to extpayresult_atms_path(:response=>@response)
  end
  
  def  datecard
    #    http://93.87.4.246/smartatm-1.0-SNAPSHOT
     session[:server] = params[:server]
     session[:cardnumber] = params[:cardnumber]
     session[:datum] = params[:datum]
     session[:tid] = params[:tid]
     redirect_to  atms_path
  end
  
end
