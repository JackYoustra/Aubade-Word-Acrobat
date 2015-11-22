import javax.swing.JFrame;
import javax.swing.JButton;
import javax.swing.Timer;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.JLabel;
import javax.swing.SwingConstants;

import java.awt.Font;

import javax.swing.JPanel;

import java.awt.Component;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Point;
import java.util.ArrayList;
import java.util.Random;


public class MainWindow extends JFrame implements ActionListener{
	private JButton btnBegin;
	private JLabel lblAubade;
	private JPanel backgroundPanel;
	
	private ArrayList<PhysicsBody> physicsComponents = new ArrayList<>();
	
	public MainWindow() {
		getContentPane().setLayout(null);
		
		backgroundPanel = new JPanel();
		backgroundPanel.setBounds(0, 0, 1016, 755);
		getContentPane().add(backgroundPanel);
		backgroundPanel.setLayout(null);
		
		final int halfwidth = backgroundPanel.getWidth()/2;
		final int halfheight = backgroundPanel.getHeight()/2;
		
		btnBegin = new JButton("Begin");
		btnBegin.setBounds(463, 188, 184, 35);
		backgroundPanel.add(btnBegin);
		btnBegin.setFont(new Font("Tahoma", Font.BOLD, 21));
		lblAubade = new JLabel("Aubade");
		lblAubade.setBounds(halfwidth-(91/2), halfheight, 282, 94);
		backgroundPanel.add(lblAubade);
		lblAubade.setFont(new Font("Lucida Calligraphy", Font.PLAIN, 68));
		lblAubade.setHorizontalAlignment(SwingConstants.CENTER);
		
		btnBegin.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				explodeStart();
			}
		});
	}

	private void explodeStart() {
		getContentPane().remove(btnBegin);
		getContentPane().remove(lblAubade);
		Random rotationRandom = new Random();
		for(String word : AubadeFileInteractor.wordList){
			final double theta = rotationRandom.nextDouble()*2*Math.PI;
			RotateLabel wordLabel = new RotateLabel(word, theta);
			PhysicsBody wordBody = new PhysicsBody(wordLabel, new Vector(Math.cos(theta), Math.sin(theta)));
			physicsComponents.add(wordBody);
			getContentPane().add(wordLabel);
		}
		Timer renderTimer = new Timer((int)(1.0/30.0 * 1000), this);
		renderTimer.start();
	}
	
	private void render(){
		for(PhysicsBody body : physicsComponents){
			final Point renderedPoint = renderedPoint(body.renderedItem.getLocation(), body.velocity);
			body.renderedItem.setLocation(renderedPoint);
		}
	}
	
	private Point renderedPoint(Point in, Vector movement){
		Point p = new Point(); // 30 fps
		p.x = in.x + (int)movement.x/30;
		p.y = in.y + (int)movement.y/30;
		return p;
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		render();
	}
}
