{%- set broker = othercomponents['hyperledger-fabric']['zkkafka'][config.kafka.cluster] %}
metadata:
  {{ config.metadata | to_nice_yaml(indent=2) | indent(2) }}
orderer:
  {{ config.orderer | to_nice_yaml(indent=2) | indent(2) }}
storage:
  {{ config.storage | to_nice_yaml(indent=2) | indent(2) }}
service:
  {{ config.service | to_nice_yaml(indent=2) | indent(2) }}
vault:
  {{ config.vault | to_nice_yaml(indent=2) | indent(2) }}
kafka:
  readinesscheckinterval: {{ config.kafka.readinesscheckinterval }}
  readinessthreshold: {{ config.kafka.readinessthreshold }}
  brokers:
{% for index in range(broker.config.kafka.replicas) %}
    - {{ broker.config.kafka.name + '-' + index | string + '.' + broker.config.kafka.brokerservicename + '.' + broker.config.metadata.namespace + '.svc.cluster.local:9092' }}
{% endfor %}
{%- if config.genesis is defined %}
genesis: |-
  {{ config.genesis | indent(2) }}
{% endif %}
{%- if config.ambassador is defined %}
ambassador:
  annotations: |-
    {{ config.ambassador.annotations | indent(4) }}
{% endif %}
