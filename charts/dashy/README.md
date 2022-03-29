# Dashy
# Legal

> NOTE! 
> <br> I am not in any kind owner of Dashy, for the tool license please refer to: https://github.com/Lissy93/dashy
> <br> This is only my self-made chart which is licensed with __Apache-2__. 

# Config

As for now, each restart of the container will cause Dashy to loose current config.
To have your own config persistent please use following command to install Dashy:

`helm upgrade --install --set-file configMap.config.data."config\.yml"=config.yml`

Where `config.yml` at the end points to Dashy config prepared by you.

# ToDo

ToDo:
- allow IngressRoute to use TLS from values (currently not supported)
- store current configuration in PVC (persistent config during restarts)
- extract ingressRoute custom library modules to external charts (another dependency will be included)



