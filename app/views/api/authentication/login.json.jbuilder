json.code 200
json.data do
    json.email @user.email
    json.token @token
    json.access @access
end
json.msg "Successfully Logged In"