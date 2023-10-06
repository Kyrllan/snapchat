//
//  EntrarViewController.swift
//  Snapchat
//
//  Created by Kyrllan Nogueira on 18/08/17.
//  Copyright © 2017 Kyrllan Nogueira. All rights reserved.
//

import UIKit
import FirebaseAuth

class EntrarViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var senha: UITextField!

    @IBAction func entrar(_ sender: Any) {
        
        if let emailR = self.email.text {
            if let senhaR = self.senha.text {
                
                
                let autenticacao = Auth.auth()
                autenticacao.signIn(withEmail: emailR, password: senhaR, completion: { (usuario, erro) in
                    
                    if erro == nil {
                        
                        if usuario == nil {
                            
                            let alerta = Alerta(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autentição, tente novamente.")
                            self.present(alerta.getAlerta(), animated: true, completion: nil)
                            
                            
                        }else{
                            
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                            
                        }
                        
                        
                    }else{
                        let alerta = Alerta(titulo: "Dados Incorretos.", mensagem: "Verifique os dados digitados e tente novamente!")
                        self.present(alerta.getAlerta(), animated: true, completion: nil)
                    }
                    
                })
                
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
