#ifndef USEHANDLER_H
#define USEHANDLER_H

#include "Poco/Net/HTTPServer.h"
#include "Poco/Net/HTTPRequestHandler.h"
#include "Poco/Net/HTTPRequestHandlerFactory.h"
#include "Poco/Net/HTTPServerParams.h"
#include "Poco/Net/HTTPServerRequest.h"
#include "Poco/Net/HTTPServerResponse.h"
#include "Poco/Net/HTTPServerParams.h"
#include "Poco/Net/HTMLForm.h"
#include "Poco/Net/ServerSocket.h"
#include "Poco/Timestamp.h"
#include "Poco/DateTimeFormatter.h"
#include "Poco/DateTimeFormat.h"
#include "Poco/Exception.h"
#include "Poco/ThreadPool.h"
#include "Poco/Util/ServerApplication.h"
#include "Poco/Util/Option.h"
#include "Poco/Util/OptionSet.h"
#include "Poco/Util/HelpFormatter.h"
#include <iostream>
#include <iostream>
#include <fstream>

using Poco::DateTimeFormat;
using Poco::DateTimeFormatter;
using Poco::ThreadPool;
using Poco::Timestamp;
using Poco::Net::HTMLForm;
using Poco::Net::HTTPRequestHandler;
using Poco::Net::HTTPRequestHandlerFactory;
using Poco::Net::HTTPServer;
using Poco::Net::HTTPServerParams;
using Poco::Net::HTTPServerRequest;
using Poco::Net::HTTPServerResponse;
using Poco::Net::NameValueCollection;
using Poco::Net::ServerSocket;
using Poco::Util::Application;
using Poco::Util::HelpFormatter;
using Poco::Util::Option;
using Poco::Util::OptionCallback;
using Poco::Util::OptionSet;
using Poco::Util::ServerApplication;

#include "../database/group.h"
#include "../database/group_message.h"
#include "../database/group_user.h"
#include "../../helper.h"

static bool hasSubstr(const std::string &str, const std::string &substr)
{
    if (str.size() < substr.size())
        return false;
    for (size_t i = 0; i <= str.size() - substr.size(); ++i)
    {
        bool ok{true};
        for (size_t j = 0; ok && (j < substr.size()); ++j)
            ok = (str[i + j] == substr[j]);
        if (ok)
            return true;
    }
    return false;
}

class GroupHandler : public HTTPRequestHandler
{
private:
    
public:
    GroupHandler(const std::string &format) : _format(format)
    {
    }
   
    void handleRequest(HTTPServerRequest &request,
                       HTTPServerResponse &response)
    {
        HTMLForm form(request, request.stream());

        long cur_user_id = TryAuth(request, response);

        if(cur_user_id == 0){
            //No Auth
            return;
        }

        try
        {
            if (hasSubstr(request.getURI(), "/create_group") &&
                (request.getMethod() == Poco::Net::HTTPRequest::HTTP_POST)&&
                form.has("group_name")&&
                form.has("able_write"))
            {               
                std::string group_name = form.get("group_name").c_str();

                std::string ableStr = form.get("able_write").c_str();

                bool able_write =(hasSubstr(ableStr, "true"));

                long author_id = cur_user_id;

                database::Group result = database::Group::save_group_to_mysql(group_name,author_id,able_write);

                database::GroupUser::add_user(result.groupId(),author_id,true,true);

                response.setStatus(Poco::Net::HTTPResponse::HTTP_OK);
                response.setChunkedTransferEncoding(true);
                response.setContentType("application/json");
                std::ostream &ostr = response.send();
                Poco::JSON::Stringifier::stringify(result.toJSON(), ostr);
                return;
            }
            else if (hasSubstr(request.getURI(), "/add_user") &&
                (request.getMethod() == Poco::Net::HTTPRequest::HTTP_POST)&&
                form.has("user_id")&&
                form.has("group_id"))
            {
                long user_id = atol(form.get("user_id").c_str());
                long group_id = atol(form.get("group_id").c_str());

                database::GroupUser::add_user(group_id,user_id,false,false);

                response.setStatus(Poco::Net::HTTPResponse::HTTP_OK);
                response.setChunkedTransferEncoding(true);
                response.setContentType("application/json");
                response.send();
                return;
            }
            if (hasSubstr(request.getURI(), "/send_message") &&
                (request.getMethod() == Poco::Net::HTTPRequest::HTTP_POST) &&
                form.has("group_id") &&
                form.has("text"))
            {
                long sender_id = cur_user_id;
                long group_id = atol(form.get("group_id").c_str());
                std::string text = form.get("text").c_str();

                database::GroupMessage::add_message(group_id,sender_id,text);

                response.setStatus(Poco::Net::HTTPResponse::HTTP_OK);
                response.setChunkedTransferEncoding(true);
                response.setContentType("application/json");
                response.send();
                return;
            }
            else if (hasSubstr(request.getURI(), "/get_unread") &&
                    (request.getMethod() == Poco::Net::HTTPRequest::HTTP_GET)&&
                    form.has("group_id"))
            {
                long user_id = cur_user_id;
                long group_id = atol(form.get("group_id").c_str());

               auto results = database::GroupMessage::get_unread(user_id,group_id);

                Poco::JSON::Array arr;
                for (auto s : results)
                    arr.add(s.toJSON());
                response.setStatus(Poco::Net::HTTPResponse::HTTP_OK);
                response.setChunkedTransferEncoding(true);
                response.setContentType("application/json");
                std::ostream &ostr = response.send();
                Poco::JSON::Stringifier::stringify(arr, ostr);

                return;
            }
        }
        catch (...)
        {
        }

        response.setStatus(Poco::Net::HTTPResponse::HTTPStatus::HTTP_NOT_FOUND);
        response.setChunkedTransferEncoding(true);
        response.setContentType("application/json");
        Poco::JSON::Object::Ptr root = new Poco::JSON::Object();
        root->set("type", "/errors/not_found");
        root->set("title", "Internal exception");
        root->set("status", Poco::Net::HTTPResponse::HTTPStatus::HTTP_NOT_FOUND);
        root->set("detail", "Request not found");
        root->set("instance", "/GroupService");
        std::ostream &ostr = response.send();
        Poco::JSON::Stringifier::stringify(root, ostr);
    }

private:
    std::string _format;
};
#endif