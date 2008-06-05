% $Id$

%% @author Jean-Sébastien Pédron <js.pedron@meetic-corp.com>

%% @doc
%% The module <strong>{@module}</strong> implements the receiving entity
%% side of the TLS feature.
%%
%% <p>
%% Note that it doesn't implement encryption, only feature negotiation
%% at the XMPP level.
%% </p>

-module(exmpp_server_tls).
-vsn('$Revision$').

-include("exmpp.hrl").

% Feature announcement.
-export([
  feature/0,
  feature/1
]).

% TLS negotiation.
-export([
  proceed/0,
  failure/0
]).

% --------------------------------------------------------------------
% Feature announcement.
% --------------------------------------------------------------------

%% @spec () -> Feature
%%     Feature = exmpp_xml:xmlnselement()
%% @doc Make a feature announcement child.
%%
%% TLS is announced as not required.
%%
%% The result should then be passed to {@link exmpp_stream:features/1}.
%%
%% @see feature/1.

feature() ->
    feature(false).

%% @spec (Is_Required) -> Feature
%%     Is_Required = bool()
%%     Feature = exmpp_xml:xmlnselement()
%% @doc Make a feature announcement child.
%%
%% The result should then be passed to {@link exmpp_stream:features/1}.

feature(Is_Required) ->
    Feature = #xmlnselement{
      ns = ?NS_TLS,
      name = 'starttls',
      children = []
    },
    if
        Is_Required ->
            Required = #xmlnselement{
              ns = ?NS_TLS,
              name = 'required',
              children = []
            },
            exmpp_xml:append_child(Feature, Required);
        true ->
            Feature
    end.

% --------------------------------------------------------------------
% TLS negotiation.
% --------------------------------------------------------------------

%% @spec () -> Proceed
%%     Proceed = exmpp_xml:xmlnselement()
%% @doc Make an XML element to tell the initiating entity it can proceed
%% with the TLS handshake.

proceed() ->
    #xmlnselement{
      ns = ?NS_TLS,
      name = 'proceed',
      children = []
    }.

%% @spec () -> Failure
%%     Failure = exmpp_xml:xmlnselement()
%% @doc Make an XML element to tell the initiating entity that the TLS
%% handshake failed.

failure() ->
    #xmlnselement{
      ns = ?NS_TLS,
      name = 'failure',
      children = []
    }.