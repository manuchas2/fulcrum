{%- set peer_id = channelpeer %}

{%- set peer = othercomponents['hyperledger-fabric']['peers'][peer_id] %}

{%- if peer.config.service.ports is defined and peer.config.service.ports.grpc is defined %}
{%- set peer_address = peer.config.peer.name + "." + peer.config.metadata.namespace +":" + peer.config.service.ports.grpc.get("clusteripport", "7051") | string %}
{%- else %}
{%- set peer_address = peer.config.peer.name + "." + peer.config.metadata.namespace + ":7051" %}
{%- endif %}

metadata:
  {{ peer.config.metadata | to_nice_yaml(indent=2) | indent(2) }}
peer:
  {{ peer.config.peer | to_nice_yaml(indent=2) | indent(2) }}
  address: {{ peer_address }}
vault:
  {{ peer.config.vault | to_nice_yaml(indent=2) | indent(2) }}
channel:
  name: {{ config.name }}
orderer:
{% if config.orderer.local is defined %}
{%- set orderer = othercomponents['hyperledger-fabric']['orderers'][config.orderer.local] %}
{%- if orderer.config.service.ports is defined and orderer.config.service.ports.grpc is defined %}
{%- set orderer_address = orderer.config.orderer.name + "." + orderer.config.metadata.namespace +":" + orderer.config.service.ports.grpc.get("clusteripport", "7050") | string %}
{%- else %}
{%- set orderer_address = orderer.config.orderer.name + "." + orderer.config.metadata.namespace + ":7050" %}
{%- endif %}
  address: {{ orderer_address }}
{% else %}
  address: {{ config.orderer.remote }}
{% endif %}
