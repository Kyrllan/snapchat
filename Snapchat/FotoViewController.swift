//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Kyrllan Nogueira on 25/08/17.
//  Copyright © 2017 Kyrllan Nogueira. All rights reserved.
//

import UIKit
import FirebaseStorage

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UITextField!
    
    @IBOutlet weak var botaoProximo: UIButton!
    
    
    @IBAction func proximoPasso(_ sender: Any) {
        
        self.botaoProximo.isEnabled = false
        self.botaoProximo.setTitle("Carregando...", for: .normal)
        
        let armazenamento = Storage.storage().reference()
        let imagens = armazenamento.child("imagens")
        
        if let imagemSelecionada = imagem.image {
            
            
            if let imagemDados = UIImageJPEGRepresentation(imagemSelecionada, 0.05) {
                
                imagens.child("\(self.idImage).jpg").putData(imagemDados, metadata: nil, completion: { (metaDados, erro) in
                    
                    if erro == nil {
                        
                        print("Sucesso ao fazer o upload do arquivo")
                      
                        let url = metaDados?.downloadURL()?.absoluteString
                        self.performSegue(withIdentifier: "selecionarUsuarioSegue", sender: url)
                        
                        
                        self.botaoProximo.isEnabled = true
                        self.botaoProximo.setTitle("Próximo", for: .normal)
                        
                    }else{
                        let alerta = Alerta(titulo: "Upload falhou", mensagem: "Erro ao salvar o arquivo, tente novamente!")
                        self.present(alerta.getAlerta(), animated: true, completion: nil)
                        
                    }
                    
                })
                
            }
            
            
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "selecionarUsuarioSegue" {
            let usuarioViewController = segue.destination as! UsuariosTableViewController
            usuarioViewController.descricao = self.descricao.text!
            usuarioViewController.urlImagem = sender as! String
            usuarioViewController.idImagem = self.idImage
        }
    }

    @IBAction func selecionarFoto(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let imagemRecuperada = info[ UIImagePickerControllerOriginalImage] as! UIImage
        
        imagem.image = imagemRecuperada
        
        botaoProximo.isEnabled = true
        botaoProximo.backgroundColor = UIColor(red: 0.553, green: 0.369, blue: 0.749, alpha: 1)
        
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    var imagePicker = UIImagePickerController()
    var idImage = NSUUID().uuidString
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        botaoProximo.isEnabled = false
        botaoProximo.backgroundColor = UIColor.gray
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
