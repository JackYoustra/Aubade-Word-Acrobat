import java.awt.Graphics;
import java.awt.Graphics2D;

import javax.swing.JLabel;


public class RotateLabel extends JLabel {

	private double theta;

	public RotateLabel(String text, double theta) {
		super(text);
		this.theta = theta;
	}


	@Override
    public void paintComponent(Graphics g) {
		Graphics2D gx = (Graphics2D) g;
		gx.rotate(theta, getX() + getWidth() / 2, getY() + getHeight() / 2);
		super.paintComponent(g);
	}

}
