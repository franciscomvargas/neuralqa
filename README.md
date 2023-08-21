# Instalation
<details>
    <summary><h2>Windows</h2></summary>

* Go to CMD as Administrator (command prompt):
    * <kbd>⊞ Win</kbd> + <kbd>R</kbd>
    * Search: `cmd` 
    * <kbd>Ctrl</kbd> + <kbd>⇧ Shift</kbd> + <kbd>↵ Enter</kbd>

* Copy-Paste the following comands: 
    ```cmd
    powershell -command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/franciscomvargas/neuralqa/master/neuralqa/executables/Windows/neuralqa.install.bat -OutFile ~\neuralqa_installer.bat"
    %UserProfile%\neuralqa_installer.bat && del %UserProfile%\neuralqa_installer.bat

    ```
    * Installer Optional `Arguments`

        <table>
            <thead>
                <tr>
                    <th>arg</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td rowspan=3>/reinstall</td>
                    <td>Overwrite project when re-installing</td>
                </tr>
                <tr>
                    <td>Delete project service when re-installing</td>
                </tr>
                <tr>
                    <td>Install without requiring user interaction</td>
                </tr>
                <tr>
                    <td>/startmodel</td>
                    <td>Start project service on instalation</td>
                </tr>
            </tbody>
        </table>
        
        ```cmd
        powershell -command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/franciscomvargas/neuralqa/master/neuralqa/executables/Windows/neuralqa.install.bat -OutFile ~\neuralqa_installer.bat"
        %UserProfile%\neuralqa_installer.bat /reinstall /startmodel && del %UserProfile%\neuralqa_installer.bat

        ```
    
    
</details>

# Service Operations
<details>
    <summary><h2>Windows</h2></summary>

* Go to CMD (command prompt):
  * <kbd>⊞ Win</kbd> + <kbd>R</kbd>
  * Search: `cmd` 
  * <kbd>Ctrl</kbd> + <kbd>⇧ Shift</kbd> + <kbd>↵ Enter</kbd>

### Start Service
* Copy-Paste the following comands: 
    ```cmd
    %UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.start.bat

    ```
### Stop Service
* Copy-Paste the following comands: 
    ```cmd
    %UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.stop.bat

    ```
</details>

# Uninstalation
<details>
    <summary><h2>Windows</h2></summary>

* Go to CMD (command prompt):
  * <kbd>⊞ Win</kbd> + <kbd>R</kbd>
  * Search: `cmd` 
  * <kbd>Ctrl</kbd> + <kbd>⇧ Shift</kbd> + <kbd>↵ Enter</kbd>

* Copy-Paste the following comands: 
    ```cmd
    %UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.uninstall.bat

    ```
    * Uninstaller Optional `Arguments`

      |arg|Description|
      |---|---|
      |/Q|Uninstall without requiring user interaction|

      ```cmd
      %UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.uninstall.bat /Q

      ```
      
</details>

# Credits / Lincense
## Citation
```
@article{dibia2020neuralqa,
    title={NeuralQA: A Usable Library for Question Answering (Contextual Query Expansion + BERT) on Large Datasets},
    author={Victor Dibia},
    year={2020},
    journal={Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing and the 9th International Joint Conference on Natural Language Processing (EMNLP-IJCNLP): System Demonstrations}
}
```

## Licence
[MIT](https://github.com/victordibia/neuralqa/blob/master/LICENSE)
