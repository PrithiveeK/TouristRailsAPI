json.code 200
json.data do
    json.email @user.email
    json.token @token
end
json.msg "Successfully Logged In"