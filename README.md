<details open>
    <summary><h1>About <a href="https://github.com/victordibia/neuralqa">NeuralQA</a></h1></summary>

[![UI Teaser](https://raw.githubusercontent.com/victordibia/neuralqa/master/docs/images/manual.jpg)](https://github.com/victordibia/neuralqa/blob/master/README.md)

</details>

<details open>
    <summary><h1>Instalation</h1></summary>

## Use DeSOTA official [Manager & Tools](https://github.com/DeSOTAai/DeManagerTools#readme)

1. [Download Installer for your Platform](https://github.com/DeSOTAai/DeManagerTools#dedicated-installer)
  
2. **Open** [`Models Instalation`](https://github.com/DeSOTAai/DeManagerTools/#install--upgrade-desota-models-and-tools) tab

3. **Select** the Available Tool `franciscomvargas/neuralqa`

4. **Press** `Start Instalation`

<details>
    <summary><h2>Manual Windows Instalation</h2></summary>

* Go to CMD (command prompt):
  * <kbd>⊞ Win</kbd> + <kbd>R</kbd>
  * Enter: `cmd` 
  * <kbd>↵ Enter</kbd>

### Download:

1. Create Model Folder:
```cmd
rmdir /S /Q %UserProfile%\Desota\Desota_Models\NeuralQA
mkdir %UserProfile%\Desota\Desota_Models\NeuralQA

```

2. Download Last Release:
```cmd
powershell -command "Invoke-WebRequest -Uri https://github.com/franciscomvargas/neuralqa/archive/refs/tags/v0.0.0.zip -OutFile %UserProfile%\NeuralQA_release.zip" 

```

3. Uncompress Release:
```cmd
tar -xzvf %UserProfile%\NeuralQA_release.zip -C %UserProfile%\Desota\Desota_Models\NeuralQA --strip-components 1 

```

4. Delete Compressed Release:
```cmd
del %UserProfile%\NeuralQA_release.zip

```

### Setup:

5. Setup:
```cmd
%UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.setup.bat

```

*  Optional Arguments:
    <table>
        <thead>
            <tr>
                <th>arg</th>
                <th>Description</th>
                <th>Example</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>/debug</td>
                <td>Log everything (useful for debug)</td>
                <td><code>%UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.setup.bat /debug</code></td>
            </tr>
            <tr>
                <td>/manualstart</td>
                <td>Don't start at end of setup</td>
                <td><code>%UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.setup.bat /manualstart</code></td>
            </tr>
        </tbody>
    </table>
    
</details>



<details>
    <summary><h2>Manual Linux Instalation</h2></summary>

* Go to Terminal:
    * <kbd> Ctrl </kbd> + <kbd> Alt </kbd> + <kbd>T</kbd>

### Download:

1. Create Model Folder:
```cmd
rm -rf ~/Desota/Desota_Models/NeuralQA
mkdir -p ~/Desota/Desota_Models/NeuralQA

```

2. Download Last Release:
```cmd
wget https://github.com/franciscomvargas/neuralqa/archive/refs/tags/v0.0.0.zip -O ~/NeuralQA_release.zip

```

3. Uncompress Release:
```cmd
sudo apt install libarchive-tools -y && bsdtar -xzvf ~/NeuralQA_release.zip -C ~/Desota/Desota_Models/NeuralQA --strip-components=1

```

4. Delete Compressed Release:
```cmd
rm -rf ~/NeuralQA_release.zip

```

### Setup:

5. Setup:
```cmd
sudo bash ~/Desota/Desota_Models/NeuralQA/neuralqa/executables/Linux/neuralqa.setup.bash

```

*  Optional Arguments:
    <table>
        <thead>
            <tr>
                <th>arg</th>
                <th>Description</th>
                <th>Example</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>-d</td>
                <td>Setup with debug Echo ON</td>
                <td><code>sudo bash ~/Desota/Desota_Models/NeuralQA/neuralqa/executables/Linux/neuralqa.setup.bash -d</code></td>
            </tr>
            <tr>
                <td>-m</td>
                <td>Don't start service at end of setup</td>
                <td><code>sudo bash ~/Desota/Desota_Models/NeuralQA/neuralqa/executables/Linux/neuralqa.setup.bash -m</code></td>
            </tr>
        </tbody>
    </table>
    
    
</details>
</details>







<details open>
    <summary><h1>Service Operations</h1></summary>

<details>
    <summary><h2>Windows</h2></summary>

* Go to CMD as Administrator (command prompt):
  * <kbd>⊞ Win</kbd> + <kbd>R</kbd>
  * Enter: `cmd` 
  * <kbd>Ctrl</kbd> + <kbd>⇧ Shift</kbd> + <kbd>↵ Enter</kbd>

### Start Service
    ```cmd
    %UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.start.bat

    ```
### Stop Service
    ```cmd
    %UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.stop.bat

    ```

### Status Service
    ```cmd
    %UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.status.bat

    ```
</details>


<details>
    <summary><h2>Linux</h2></summary>

* Go to Terminal:
    * <kbd> Ctrl </kbd> + <kbd> Alt </kbd> + <kbd>T</kbd>

### Start Service
    ```cmd
    sudo bash ~/Desota/Desota_Models/NeuralQA/neuralqa/executables/Linux/neuralqa.start.bash

    ```
    
### Stop Service
    ```cmd
    sudo bash ~/Desota/Desota_Models/NeuralQA/neuralqa/executables/Linux/neuralqa.stop.bash

    ```

### Status Service
    ```cmd
    bash ~/Desota/Desota_Models/NeuralQA/neuralqa/executables/Linux/neuralqa.status.bash

    ```
</details>
</details>




<details open>
    <summary><h1>Uninstalation</h1></summary>

## Use DeSOTA official [Manager & Tools](https://github.com/DeSOTAai/DeManagerTools#readme)

1. **Open** [`Models Dashboard`](https://github.com/DeSOTAai/DeManagerTools/#models--tools-dashboard) tab

2. **Select** the model `franciscomvargas/neuralqa`

3. **Press** `Uninstall`

<details>
    <summary><h2>Manual Windows Uninstalation</h2></summary>

* Go to CMD as Administrator (command prompt):
  * <kbd>⊞ Win</kbd> + <kbd>R</kbd>
  * Enter: `cmd` 
  * <kbd>Ctrl</kbd> + <kbd>⇧ Shift</kbd> + <kbd>↵ Enter</kbd>

```cmd
%UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.uninstall.bat

```

* Optional `Arguments`

    |arg|Description|Example
    |---|---|---|
    |/Q|Uninstall without requiring user interaction|`%UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.uninstall.bat /Q`
      
</details>



<details>
    <summary><h2>Manual Linux Uninstalation</h2></summary>

* Go to Terminal:
    * <kbd> Ctrl </kbd> + <kbd> Alt </kbd> + <kbd>T</kbd>

```cmd
sudo bash ~/Desota/Desota_Models/DeScraper/executables/Linux/descraper.uninstall.bash

```

* Optional `Arguments`

    |arg|Description|Example
    |---|---|---|
    |-q|Uninstall without requiring user interaction|`sudo bash ~/Desota/Desota_Models/NeuralQA/neuralqa/executables/Linux/neuralqa.uninstall.bash -q`
      
</details>
</details>





<details open>
    <summary><h1>Credits / Lincense</h1></summary>

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

</details>
