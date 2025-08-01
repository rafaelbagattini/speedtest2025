<h1>PAINÉIS NECESSÁRIOS PARA UTILIZAÇÃO DESSE DASHBOARD</h1>

* Business Media (by Volko Labs)
  https://volkovlabs.io/plugins/business-media/
  
  <img width="301" height="185" alt="image" src="https://github.com/user-attachments/assets/dfd8e959-6bad-4975-bddf-1edac39d64a2" />
  

* Dynamic image panel (by dalvany)
  https://grafana.com/grafana/plugins/dalvany-image-panel/?tab=installation
  
  <img width="293" height="181" alt="image" src="https://github.com/user-attachments/assets/eaf69230-a61f-4dae-921d-419e6ca540d3" />

Instale-os pela interface gráfica do Grafana em: <b>Administration -> Plugins and data -> Plugins</b>

Ou por linha de comando (CLI):
```bash
sudo -u grafana grafana-cli plugins install volkovlabs-image-panel
```

```bash
sudo -u grafana grafana-cli plugins install dalvany-image-panel
```

🚨 Se executado sem o 'sudo -u grafana', a pasta do plugin ficará com permissões apenas para o 'root'.


<h1>DEMONSTRAÇÃO DO DASHBOARD</h1>

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/0bbd4525-381c-4872-814f-02bb2903e0a5" />

